module VktDriver
  # Read Vkt7 item info
  class ItemInfoReader < BaseExecuter(ParameterInfoWithData)
    # Size of digits element
    DIGITS_SIZE = 1_u16
    # Size of measure type element
    MEASURE_TYPE_SIZE = 7_u16

    # Meter version
    @version : UInt8

    # Parameters to get data
    @requests = Set(ParameterInfo).new

    # Get scaler for measure
    private def getScaler(measure : String) : Float64
      case measure
      when ""

      end

      return 1_f64
    end

    def initialize(deviceInfo : MeterDeviceInfo, protocol : ModbusRtuProtocol, @version : UInt8)
      super(deviceInfo, protocol)
    end

    # Add item to read info
    def addItemType(parameter : ParameterInfo) : Void
      @requests.add(parameter)
    end

    # Execute and iterate values in block
    def execute(&block : ParameterInfoWithData -> Void) : Void
      network = @deviceInfo.networkNumber.to_u8

      elementRequests = Array(ElementRequest).new

      @requests.each do |item|
        element = ElementRequest.new(item.digitsType, DIGITS_SIZE)
        elementRequests.push(element)
        element = ElementRequest.new(item.measureType, MEASURE_TYPE_SIZE)
        elementRequests.push(element)
      end

      # Select items
      itemSelector = SelectItemsExecuter.new(@deviceInfo, @protocol, Vkt7SystemDataType::Property)
      elementRequests.each do |x|
        itemSelector.addItemType(x)
      end
      itemSelector.execute

      dataReader = ItemValueReader.new(@deviceInfo, @protocol, @version)
      elementRequests.each do |item|
        dataReader.addItemType(item)
      end

      activeElements = Hash(Vkt7DataElementType, UInt16).new
      activeReader = ActiveElementReader.new(@deviceInfo, @protocol)
      activeReader.execute do |element|
        activeElements[element.elementType] = element.size
      end      

      state = 0
      digits = 0
      scaler = 1_f64
      dataReader.execute do |value|
        case state
        when 0  # Digit size state
          digits = value.data.to_i32
          state = 1
        when 1  # Measure type state
          @requests.each do |param|
            elementSize = activeElements[param.valueType]?
            next unless elementSize

            scaler = getScaler(value.data.to_s)

            yield ParameterInfoWithData.new(
              param.measureParameter,
              param.requestParameter,
              param.measureType,
              param.digitsType,
              param.valueType,
              digits,
              elementSize,
              scaler
            )
          end
          state = 0
        end
      end
    end
  end
end

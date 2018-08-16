module Vkt7Driver
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
      itemSelector = SelectItemsExecuter.new(@deviceInfo, @protocol, Vkt7DataType::Property)
      elementRequests.each do |x|
        itemSelector.addItemType(x)
      end
      itemSelector.execute

      dataReader = ItemValueReader.new(@deviceInfo, @protocol, @version)
      elementRequests.each do |item|
        dataReader.addItemType(item)
      end

      dataReader.execute do |value|
        
      end
    end
  end
end

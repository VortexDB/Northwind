require "./common/base_executer"

module Vkt7Driver
  struct ProfileValueResponse
    # Measure parameter of response
    getter measureParameter : MeasureParameter

    # Value from device
    getter value : Float64

    # Value time
    getter dateTime : Time

    def initialize(@measureParameter, @value, @dateTime)
    end
  end

  # Read profile from device
  class ProfileReader < CommonValueExecuter(ProfileValueResponse)
    # Profile type
    getter profileType : Vkt7ProfileDataType

    # Start datetime
    getter startDate : Time

    # End datetime
    getter endDate : Time

    # Read values from device
    private def readValues(params : Array(ParameterInfoWithData), requestDate : Time, &block : ProfileValueResponse -> Void) : Void
      network = @deviceInfo.networkNumber.to_u8

      # Write date to read
      binary = IO::Memory.new
      binary.write_bytes(0x04_u8)
      binary.write_bytes(requestDate.day.to_u8)           # Day
      binary.write_bytes(requestDate.month.to_u8)         # Month
      binary.write_bytes((requestDate.year - 2000).to_u8) # Year
      binary.write_bytes(requestDate.hour.to_u8)          # Hour
      response = @protocol.sendRequestWithResponse(PresetMultipleRegistersRequest.new(
        network, Vkt7StartAddress::WriteElementTypes, 0_u16, binary.to_slice))

      # Read values
      dataReader = ItemValueReader.new(@deviceInfo, @protocol, @serverVersion)
      params.each do |item|
        element = ElementRequest.new(item.valueType, item.elementSize)
        dataReader.addItemType(element)
      end

      dataReader.execute do |value|
        params.each do |param|
          if param.valueType == value.element
            data = value.data
            case data
            when Float64
              yield ProfileValueResponse.new(param.measureParameter, data, requestDate)
            end
          end
        end
      end
    end

    def initialize(deviceInfo : MeterDeviceInfo,
                   protocol : ModbusRtuProtocol,
                   @startDate : Time,
                   @endDate : Time,
                   @profileType : Vkt7ProfileDataType)
      super(deviceInfo, protocol)
    end

    # Execute and iterate values in block
    def postExecute(&block : ProfileValueResponse -> Void) : Void
      devInfo = @deviceInfo
      case devInfo
      when PipeDeviceInfo
        parameterInfos = @parameters.map { |x| Vkt7Model.getParameterInfo(x, devInfo) }
        infoReader = ItemInfoReader.new(@deviceInfo, @protocol, @serverVersion)
        parameterInfos.each do |x|
          infoReader.addItemType(x)
        end

        itemsInfo = Array(ParameterInfoWithData).new
        infoReader.execute do |infoData|
          itemsInfo.push(infoData)
        end

        itemSelector = SelectItemsExecuter.new(@deviceInfo, @protocol, @profileType)
        itemSelector.execute

        workTime = startDate

        while workTime < endDate
          readValues(itemsInfo, workTime, &block)
          workTime = ProfileDataTypeHelper.incDate(workTime, @profileType)
        end
      end
    end
  end
end

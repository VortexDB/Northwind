require "./common/base_executer"

module Vkt7Driver
  # Read profile from device
  class ProfileReader < CommonValueExecuter(Float64)
    # Profile type
    getter profileType : Vkt7ProfileDataType

    # Start datetime
    getter startDate : Time

    # End datetime
    getter endDate : Time
    
    # Read values from device
    private def readValues(params : Array(ParameterInfoWithData), requestDate : Time, &block : Float64 -> Void) : Void
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
    end

    def initialize(deviceInfo : MeterDeviceInfo,
                   protocol : ModbusRtuProtocol,
                   @startDate : Time,
                   @endDate : Time,
                   @profileType : Vkt7ProfileDataType)
      super(deviceInfo, protocol)
    end

    # Execute and iterate values in block
    def postExecute(&block : Float64 -> Void) : Void      
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

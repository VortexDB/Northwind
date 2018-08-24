require "./common/base_executer"

module Vkt7Driver
  # Read profile from device
  class ProfileReader < CommonValueExecuter(Float64)
    # Profile type
    getter profileType : Vkt7ProfileDataType

    def initialize(deviceInfo : MeterDeviceInfo, protocol : ModbusRtuProtocol, @profileType : Vkt7ProfileDataType)
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
      end
    end
  end
end

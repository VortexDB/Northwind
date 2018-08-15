require "./common/base_executer"

module Vkt7Driver
  # Read time
  class ValueReader < CommonExecuter(Float64)
    # Requests
    @parameters = Set(MeasureParameter).new

    # Add parameter for reading
    def addParameter(parameter : MeasureParameter) : Void
      @parameters.add(parameter)
    end

    # Execute and iterate values in block
    def postExecute(&block : Float64 -> Void) : Void
      devInfo = @deviceInfo
      case devInfo
      when PipeDeviceInfo
        parameterInfos = @parameters.map { |x| Vkt7Model.getParameterInfo(x, devInfo) }
        infoReader = ItemInfoReader.new(@deviceInfo, @protocol)
        parameterInfos.each do |x|
          infoReader.addItemType(x)
        end

        # TODO switch current and total
        currentInfoItems = Array(ParameterInfoWithData).new
        infoReader.execute do |infoData|
          currentInfoItems.push(infoData)
        end

        # network = @deviceInfo.networkNumber.to_u8

        # # Select data type
        # response = @protocol.sendRequestWithResponse(PresetMultipleRegistersRequest.new(
        #   network, Vkt7StartAddress::WriteDataType, 0_u16, Bytes[0x02, Vkt7DataType::CurrentValue, 0x00]))

        # # TODO current and total
        # itemSelector = SelectItemsExecuter.new(@deviceInfo, @protocol)
        # currentInfoItems.each do |item|
        #   element = ElementRequest.new(item.valueType, item.digits.to_u16)
        #   itemSelector.addItemType(element)
        # end

        # itemSelector.execute do |_|
        # end

        # response = @protocol.sendRequestWithResponse(ReadHoldingRegistersRequest.new(network, Vkt7StartAddress::ReadDataAddress, 0_u16))
        # pp response
      else
        raise NorthwindException.new("Unsupported device type")
      end
    end
  end
end

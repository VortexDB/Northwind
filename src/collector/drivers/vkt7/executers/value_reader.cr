require "./common/base_executer"

module Vkt7Driver
  struct ValueResponse
    # Measure parameter of response
    getter measureParameter : MeasureParameter

    # Value from device
    getter value : Float64

    def initialize(@measureParameter, @value : Float64)
    end
  end

  # Read time
  class ValueReader < CommonValueExecuter(ValueResponse)
    # Read values from device
    private def readValues(params : Array(ParameterInfoWithData), currentType : Vkt7CurrentDataType, &block : ValueResponse -> Void) : Void
      itemSelector = SelectItemsExecuter.new(@deviceInfo, @protocol, currentType)
      dataReader = ItemValueReader.new(@deviceInfo, @protocol, @serverVersion)

      params.each do |item|
        element = ElementRequest.new(item.valueType, item.elementSize)
        itemSelector.addItemType(element)
        dataReader.addItemType(element)
      end

      itemSelector.execute

      dataReader.execute do |value|
        params.each do |param|
          if param.valueType == value.element
            data = value.data
            case data
            when Float64
              yield ValueResponse.new(param.measureParameter, data)
            end
          end
        end
      end
    end

    # Execute and iterate values in block
    def postExecute(&block : ValueResponse -> Void) : Void
      devInfo = @deviceInfo
      case devInfo
      when PipeDeviceInfo
        parameterInfos = @parameters.map { |x| Vkt7Model.getParameterInfo(x, devInfo) }
        infoReader = ItemInfoReader.new(@deviceInfo, @protocol, @serverVersion)
        parameterInfos.each do |x|
          infoReader.addItemType(x)
        end

        currentInfoItems = Array(ParameterInfoWithData).new
        totalInfoItems = Array(ParameterInfoWithData).new
        infoReader.execute do |infoData|
          case MeasureParameterHelper.getCurrentType(infoData.measureParameter)
          when Vkt7CurrentDataType::CurrentValue
            currentInfoItems.push(infoData)
          when Vkt7CurrentDataType::TotalValue
            totalInfoItems.push(infoData)
          end
        end

        # Read current
        if !currentInfoItems.empty?
          readValues(currentInfoItems, Vkt7CurrentDataType::CurrentValue, &block)
        end

        # Read total
        if !totalInfoItems.empty?
          readValues(totalInfoItems, Vkt7CurrentDataType::TotalValue, &block)
        end
      else
        raise NorthwindException.new("Unsupported device type")
      end
    end
  end
end

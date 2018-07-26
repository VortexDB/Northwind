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
      devInfo =  @deviceInfo
      case devInfo
      when PipeDeviceInfo
        parameterInfos = @parameters.map { |x| Vkt7Model.getParameterInfo(x, devInfo) }      
        ItemInfoReader.new(@deviceInfo, @protocol) do |infoData|
        end
      else
        raise NorthwindException.new("Unsupported device type")
      end      
    end
  end
end

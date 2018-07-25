require "./common/base_executer"

module Vkt7Driver
  # Read time
  class ValueReader < CommonExecuter(Float64)
    # Requests
    @requestParameters = Set(RequestParameter).new

    # Add parameter for reading
    def addParameter(parameter : RequestParameter) : Void
      @requestParameters.add(parameter)
    end

    # Execute and iterate values in block
    def postExecute(&block : Float64 -> _) : Void
      parameterInfos = @requestParameters.map { |x| Vkt7Model.getParameterInfoByRequestParameter(x) }      
      ItemInfoReader.new(parameterInfos) do |infoData|

      end            
    end
  end
end

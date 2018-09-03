module Spt96xDriver
    # Response after read parameter
    class ReadParameterResponse
        # Parameter info
        getter parameter : RequestParameter

        # Data
        getter data : ParameterData

        def initialize(@parameter, @data)            
        end
    end
end
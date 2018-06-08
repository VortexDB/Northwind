module Spt96xDriver
    # Parameter used for request
    class RequestParameter
        # Channel number(pipe)
        getter channel : String

        # Measure parameter number
        getter parameter : String

        def initialize(@channel, @parameter)            
        end
    end
end
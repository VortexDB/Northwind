module Spt96xDriver
    # Data of parameter
    class ParameterData
        # Value
        getter value : String

        # Measure
        getter measure : String?

        # Value date
        getter date : Time?

        def initialize(@value, @measure, @date)            
        end
    end
end
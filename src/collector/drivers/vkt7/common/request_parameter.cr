module Vkt7Driver
    # Request parameter for Vkt7 driver
    struct RequestParameter
        # Number of device pipe
        getter pipeNumber : Int32

        # Number of heat system
        getter groupNumber : Int32

        def initialize(@pipeNumber, @groupNumber)
        end
    end
end
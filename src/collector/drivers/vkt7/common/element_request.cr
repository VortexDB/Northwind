module Vkt7Driver
    # Request for element
    struct ElementRequest
        # Item id : Vkt7MeasureElementType, Vkt7FractionElementType, Vkt7DataElementType
        getter itemId : UInt8

        # Size of element
        getter size : UInt16

        def initialize(@itemId, @size)
        end
    end
end
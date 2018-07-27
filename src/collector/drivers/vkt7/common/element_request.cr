module Vkt7Driver
    # Request for element
    struct ElementRequest
        # Item type : Vkt7MeasureElementType, Vkt7FractionElementType, Vkt7DataElementType
        getter itemType : Vkt7ElementType

        # Size of element
        getter size : UInt16

        def initialize(@itemType, @size)
        end
    end
end
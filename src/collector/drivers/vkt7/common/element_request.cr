module Vkt7Driver
    # Request for element
    struct ElementRequest
        # Item type : Vkt7MeasureElementType, Vkt7FractionElementType, Vkt7DataElementType
        getter itemType : Vkt7ElementType

        # Size of element
        getter size : UInt16

        def initialize(@itemType, @size)
        end

        def hash
            itemType.hash
        end

        def ==(other : ElementRequest)
            itemType == other.itemType
        end
    end
end
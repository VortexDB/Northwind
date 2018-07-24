module Vkt7Driver
    # Info about request parameter
    class ParameterInfo
        # Request parameter
        getter requestParameter : RequestParameter

        # Measure type
        getter measureType : Vkt7MeasureElementType

        # Fraction type
        getter digitsType : Vkt7FractionElementType

        # Value type for request
        getter valueType : Vkt7DataElementType

        def initialize(@requestParameter, @measureType, @digitsType, @valueType)
            
        end
    end
end
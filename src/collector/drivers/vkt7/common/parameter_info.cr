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

    # Parameter info with data from device
    class ParameterInfoWithData < ParameterInfo
        # Loaded digit data from device
        getter digits : Int32

        # Loaded element size data
        getter elementSize : UInt16

        # Scaler for data
        getter scaler : Float64
        
        def initialize(requestParameter, 
            measureType, 
            digitsType, 
            valueType,
            @digits,
            @elementSize,
            @scaler)
            super(requestParameter, measureType, digitsType, valueType)
        end
    end
end
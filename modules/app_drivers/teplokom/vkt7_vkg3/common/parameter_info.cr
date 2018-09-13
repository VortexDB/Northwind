module VktDriver
    # # Info about request parameter
    # class ParameterInfo
    #     # Collector Measure parameter
    #     getter measureParameter : MeasureParameter

    #     # Request parameter
    #     getter requestParameter : RequestParameter

    #     # Measure type
    #     getter measureType : Int32

    #     # Fraction type
    #     getter digitsType : Int32

    #     # Value type for request
    #     getter valueType : Int32        

    #     def initialize(@measureParameter, 
    #         @requestParameter, 
    #         @measureType, 
    #         @digitsType, 
    #         @valueType)
    #     end
    # end

    # # Parameter info with data from device
    # class ParameterInfoWithData < ParameterInfo
    #     # Loaded digit data from device
    #     getter digits : Int32

    #     # Loaded element size data
    #     getter elementSize : UInt16

    #     # Scaler for data
    #     getter scaler : Float64
        
    #     def initialize(measureParameter,
    #         requestParameter, 
    #         measureType, 
    #         digitsType, 
    #         valueType,
    #         @digits,
    #         @elementSize,
    #         @scaler)
    #         super(measureParameter, requestParameter, measureType, digitsType, valueType)
    #     end
    # end
end
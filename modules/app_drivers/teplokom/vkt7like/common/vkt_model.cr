module VktDriver
    # Abstract VKT model
    abstract class VktModel
        # Get parameter info
        abstract def getParameterInfo(measureParameter : MeasureParameter, device : PipeDeviceInfo) : ParameterInfo
    end
end
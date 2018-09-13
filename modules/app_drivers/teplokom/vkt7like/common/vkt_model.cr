module VktDriver
    # Abstract VKT model
    abstract class VktModel
        # Information about device
        getter deviceInfo : MeterDeviceInfo

        # Return network number
        def networkNumber : UInt8
            return deviceInfo.networkNumber.to_u8
        end

        def initialize(@deviceInfo)
        end

        # Get parameter info
        abstract def getParameterInfo(measureParameter : MeasureParameter) : ParameterInfo
    end
end
module Vkt7Driver
    module Vkt7Model
        # Return temperature digits type
        def self.getTemperatureDigitsType(requestParameter : RequestParameter) : Vkt7FractionElementType?
            return case requestParameter.groupNumber
            when 1 then Vkt7FractionElementType::TTypeFractDiNum
            when 2 then Vkt7FractionElementType::TTypeFractDigNum2
            end
        end

        # Get temperature value type
        def self.getTemperatureValueType(requestParameter : RequestParameter) : Vkt7DataElementType?
            return case {requestParameter.pipeNumber, requestParameter.groupNumber}
            when {1,1} then Vkt7DataElementType::T1_1Type
            when {2,1} then Vkt7DataElementType::T2_1Type
            when {3,1} then Vkt7DataElementType::T3_1Type
            end            
        end

        # Get temperature parameter info
        def self.getTemperatureInfo(measureParameter : MeasureParameter, requestParameter : RequestParameter) : ParameterInfo?
            digitsType = self.getTemperatureDigitsType(requestParameter)
            valueType = self.getTemperatureValueType(requestParameter)
            return nil if digitsType.nil? || valueType.nil?
            measureType = Vkt7MeasureElementType::TTypeM
            return ParameterInfo.new(requestParameter, measureType, digitsType, valueType)
        end

        # Get parameter info by measure parameter and device info
        def self.getParameterInfo(measureParameter : MeasureParameter, device : PipeDeviceInfo) : ParameterInfo
            requestParameter = RequestParameter.new(device.pipeNumber, device.groupNumber)
            
            res : ParameterInfo?
            case measureParameter.measureType
            when MeasureType::TEMPERATURE
                res = self.getTemperatureInfo(measureParameter, requestParameter)                
            end

            return res || raise NorthwindException.new("Unsupported parameter")
        end
    end
end
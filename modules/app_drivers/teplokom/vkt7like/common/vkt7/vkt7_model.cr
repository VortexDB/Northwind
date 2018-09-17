module VktDriver
    # Model for VKT-7 meter
    class Vkt7Model < VktModel
        def initialize(deviceInfo)
            super(deviceInfo)
        end

        # Get parameter info by measure parameter and device info
        def getParameterInfo(measureParameter : MeasureParameter) : ParameterInfo
            # requestParameter = RequestParameter.new(device.pipeNumber, device.groupNumber)
            
            # res : ParameterInfo?
            # case measureParameter.measureType
            # when MeasureType::TEMPERATURE
            #     res = self.getTemperatureInfo(measureParameter, requestParameter)
            # end

            # return res || raise NorthwindException.new("Unsupported parameter")
            raise NorthwindException.new("Unsupported parameter")
        end
    end

    # class Vkt7Model < VktModel
    #     # Return temperature digits type
    #     private def getTemperatureDigitsType(requestParameter : RequestParameter) : Vkt7FractionElementType?
    #         return case requestParameter.groupNumber
    #         when 1 then Vkt7FractionElementType::TTypeFractDiNum
    #         when 2 then Vkt7FractionElementType::TTypeFractDigNum2
    #         end
    #     end

    #     # Get temperature value type
    #     private def getTemperatureValueType(requestParameter : RequestParameter) : Vkt7DataElementType?
    #         return case {requestParameter.pipeNumber, requestParameter.groupNumber}
    #         when {1,1} then Vkt7DataElementType::T1_1Type
    #         when {2,1} then Vkt7DataElementType::T2_1Type
    #         when {3,1} then Vkt7DataElementType::T3_1Type
    #         end
    #     end

    #     # Get temperature parameter info
    #     private def getTemperatureInfo(measureParameter : MeasureParameter, requestParameter : RequestParameter) : ParameterInfo?
    #         digitsType = self.getTemperatureDigitsType(requestParameter)
    #         valueType = self.getTemperatureValueType(requestParameter)
    #         return nil if digitsType.nil? || valueType.nil?
    #         measureType = Vkt7MeasureElementType::TTypeM
    #         return ParameterInfo.new(measureParameter, requestParameter, measureType, digitsType, valueType)
    #     end        
    # end
end
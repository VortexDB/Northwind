module Vkt7Driver
    module Vkt7Model
        # Get parameter info by measure parameter and device info
        def self.getParameterInfo(measureParameter : MeasureParameter, requestParameter : RequestParameter) : ParameterInfo
            case measureParameter.measureType.baseMeasure
            when BaseMeasureType::Temperature
            end
        end
    end
end
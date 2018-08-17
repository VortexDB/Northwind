module Vkt7Driver
    # Type of current data : Current, Total
    enum CurrentType
        Current,
        Total
    end

    # Helper to measure parameter
    class MeasureParameterHelper
        # Get parameter current type
        def self.getCurrentType(param : MeasureParameter) : CurrentType
            case param.measureType
            when MeasureType::TEMPERATURE
                return CurrentType::Current
            end
        end

        raise NorthwindException.new("Unsupported parameter")
    end
end
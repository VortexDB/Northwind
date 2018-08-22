module Vkt7Driver
  # Helper to measure parameter
  class MeasureParameterHelper
    # Get parameter current type
    def self.getCurrentType(param : MeasureParameter) : Vkt7CurrentDataType
      case param.measureType
      when MeasureType::TEMPERATURE
        return Vkt7CurrentDataType::CurrentValue
      end
      raise NorthwindException.new("Unsupported parameter")
    end

    # Get profile type
    def self.getProfileType(param : MeasureParameter) : Vkt7ProfileDataType
      case param.discret.discretType
      when DiscretType::Hour
        return Vkt7ProfileDataType::HourProfile
      when DiscretType::Day
        return Vkt7ProfileDataType::DayProfile
      when DiscretType::Month
        Vkt7ProfileDataType::MonthProfile
      end

      raise NorthwindException.new("Unsupported parameter")
    end
  end
end

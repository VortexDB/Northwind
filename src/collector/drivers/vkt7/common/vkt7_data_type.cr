module Vkt7Driver
  # Sum of data types
  alias Vkt7DataType = Vkt7CurrentDataType | Vkt7ProfileDataType | Vkt7SystemDataType

  # Current data type
  enum Vkt7CurrentDataType
    CurrentValue = 4,
    TotalValue   = 5
  end

  # Profile data type
  enum Vkt7ProfileDataType
    HourProfile  = 0,
    DayProfile   = 1,
    MonthProfile = 2,
    TotalProfile = 3
  end

  # Other data type
  enum Vkt7SystemDataType
    Property     = 6
  end

  # Helper for profile data type
  class ProfileDataTypeHelper
    # Get period for profile data type
    def self.incDate(dateTime : Time, profileType : Vkt7ProfileDataType) : Time
      case profileType
      when Vkt7ProfileDataType::HourProfile 
        return dateTime + 1.hours
      when Vkt7ProfileDataType::DayProfile
        return dateTime + 1.days
      when Vkt7ProfileDataType::MonthProfile, Vkt7ProfileDataType::TotalProfile
        return dateTime + 1.months
      end

      raise NorthwindException.new("Unknown profile type")
    end
  end
end

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
end

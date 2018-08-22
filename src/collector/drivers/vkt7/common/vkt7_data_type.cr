module Vkt7Driver
  alias Vkt7DataType = Vkt7CurrentDataType | Vkt7ProfileDataType | Vkt7SystemDataType

  enum Vkt7CurrentDataType
    CurrentValue = 4,
    TotalValue   = 5
  end

  enum Vkt7ProfileDataType
    HourProfile  = 0,
    DayProfile   = 1,
    MonthProfile = 2,
    TotalProfile = 3,
  end

  enum Vkt7SystemDataType
    Property     = 6
  end
end

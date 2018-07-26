module Vkt7Driver
    # Return item type
    enum Vkt7DataType
        HourProfile = 0,
        DayProfile = 1,
        MonthProfile = 2,
        TotalProfile = 3,
        CurrentValue = 4,
        TotalValue = 5,
        Property = 6
    end
end
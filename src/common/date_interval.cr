# Interval with start and end dates
struct DateInterval
    # Start date
    getter startDate : Time
    
    # End date
    getter endDate : Time
    
    def initialize(@startDate, @endDate)        
    end
end
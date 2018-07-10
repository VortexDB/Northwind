# Schedule for periodic start
class PeriodicSchedule
    include Schedule

    # Offset date
    @offsetDate : Time?

    # Offset time
    getter offset : Time::Span

    # Start period
    getter period : Time::Span
    
    def initialize(@offset, @period)        
    end

    # Return next start
    def nextStart : Time::Span
        now = Time.now

        if @offsetDate.nil?
            @offsetDate = Time.new(now.year, now.month, now.day)
            @offsetDate = @offsetDate.not_nil! + @offset
        end

        offDate = @offsetDate.not_nil!
        
        between = now - offDate
        parts  = (between.total_seconds / period.total_seconds).to_i
        offDate = offDate + Time::Span.new(seconds: period.total_seconds.to_i * parts, nanoseconds: 0)        
        startDate = offDate + period
        res = startDate - now
        @offsetDate = offDate
        return res
    end
end
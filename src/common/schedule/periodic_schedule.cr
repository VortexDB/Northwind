require "./schedule"

# Периодическое расписание
class PeriodicSchedule
    include Schedule

    # Дата смещения
    @offsetDate : Time?

    # Дата смещения
    getter offset : Time::Span

    # Период запуска
    getter period : Time::Span

    # Конструктор
    def initialize(@offset, @period)        
    end

    # Возвращает время следующего запуска
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
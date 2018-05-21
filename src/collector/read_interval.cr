# Интервал чтения
struct ReadInterval
    # Начальная дата
    getter startDate : Time
    # Конечная дата
    getter endDate : Time

    # Конструктор
    def initialize(@startDate, @endDate)        
    end
end
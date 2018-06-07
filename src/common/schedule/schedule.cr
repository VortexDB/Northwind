# Абстрактное расписание выполнения
module Schedule
    # Возвращает время следующего запуска
    abstract def nextStart : Time::Span    
end
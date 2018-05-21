require "./collector_script"
require "../common/schedule/periodic_schedule"

# Занимается сбором данных по счётчикам
class Collector
    # Сценарии
    @scripts = Array(CollectorScript).new    

    # Запускает сборщик
    def start
        init
        work
    end

    # Инициализирует
    def init
        # TODO: загружать сценарии
        offset = Time::Span.new(seconds: 0, nanoseconds: 0)
        period = Time::Span.new(seconds: 60 * 3, nanoseconds: 0)
        @scripts.push(CollectorScript.new(
            "Сбор показаний",
            PeriodicSchedule.new(offset, period)))
    end

    # Основная работа
    def work : Void
        # Проходит по всем сценариям и запускает их
        @scripts.each do |script|
            spawn do
                begin
                    script.start
                rescue e
                    puts e
                end
            end
        end
    end
end
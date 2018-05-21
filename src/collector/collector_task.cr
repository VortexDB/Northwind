require "./collector_device"
require "./read_interval"
require "../common/parameters/measure_parameter"

# Задание автосбора
abstract class CollectorTask
    # Счётчик идентификаторов
    @@counter : Int32 = 1

    # Идентификатор задания
    getter id : Int32

    # Усптройство по которому идёт запрос
    getter device : CollectorDevice

    # Конструктор
    def initialize(@device)
        @id = @@counter
        @@counter += 1
    end
end

# Задание на чтение данных
class CollectorDataTask < CollectorTask
    # Интервал чтения
    getter interval : ReadInterval

    # Параметр чтения
    getter parameter : MeasureParameter

    # Конструктор
    def initialize(device, @parameter, @interval)
        super(device)
    end
end
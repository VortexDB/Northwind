require "../common/schedule/schedule"
require "../common/parameters/measure_parameter"
require "./collector_device"
require "./collector_task"
require "./read_interval"

# Сценарий автосбора, запускающийся по расписанию
class CollectorScript
    # Период с которым запускается таймер, секунды
    PERIOD = 10

    # Расписание
    @schedule : Schedule

    # Устройства сгруппированные по драйверам
    @drivers : Hash(CollectorDriver, Set(CollectorDevice))

    # Устройства по которым ведётся сбор
    @devices : Set(CollectorDevice)

    # Параметры измерения по которым опрашиваются устройства
    @parameters : Set(MeasureParameter)
    
    # Глубина запроса
    @deep : Int32 = 3

    # Признак работы сценария
    getter isWorking : Bool = false

    # Название сценария
    getter name : String

    # Запускает расписание
    private def startSchedule : Void
        return unless @isWorking
        nextStart = @schedule.nextStart
        puts "Name: #{@name} Next start: #{nextStart}"
        delay(nextStart) do
            startCollect
            startSchedule
        end
    end

    # Запускает сбор
    private def startCollect : Void
        now = Time.now
        startTime = now + Time::Span.new(@deep, 0, 0)
        endTime = now
        interval = ReadInterval.new(startTime, endTime)

        # Добавляет драйверам задания
        @drivers.each do |driver, devices|
            devices.each do |dev|
                @parameters.each do |par|                    
                    task = CollectorDataTask.new(dev, par, interval)
                    driver.appendTask(task)
                end
            end            
        end
    end

    # Конструктор
    def initialize(@name, @schedule)
        @devices = Set(CollectorDevice).new
        @parameters = Set(MeasureParameter).new
        @drivers = Hash(CollectorDriver, Set(CollectorDevice)).new
        # Группирует по драйверам
        (@devices.group_by &.driver).each do |k, v|
            @drivers[k] = v.to_set
        end
    end

    # Запускает скрипт
    def start : Void
        @isWorking = true
        startSchedule
    end

    # Останавливает сценарий
    def stop : Void
        @isWorking = false
    end
end
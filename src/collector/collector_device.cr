require "./collector_driver"

# Устройство автосбора
class CollectorDevice
    # Драйвер сбора
    getter driver : CollectorDriver

    # Конструктор
    def initialize(@driver)
    end
end
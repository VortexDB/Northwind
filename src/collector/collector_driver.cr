# Абстрактный драйвера сбора
abstract class CollectorDriver   
    # Сценарий сбора
    @ownerScript : CollectorScript
    
    # Добавляет задание автосбора
    abstract def appendTask(task : CollectorTask) : Void


    def initialize(@ownerScript)
    end    
end
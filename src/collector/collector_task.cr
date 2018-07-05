module Collector
  include Device

  # Tasks by device
  class CollectorDeviceTasks
    # Device to collect data
    getter device : CollectorDevice

    # Tasks for device
    getter tasks : Array(CollectorTask)

    def initialize(@device, @tasks)
    end
  end

  # Collector task
  abstract class CollectorTask
    # Counter of identifier
    class_property counter : Int32 = 1

    # Identifier of task
    getter taskId : Int32

    def initialize
      @taskId = CollectorTask.counter
      CollectorTask.counter += 1
    end
  end

  # Task for reading data
  class CollectorDataTask < CollectorTask
    # Interval of reading
    getter interval : DateInterval

    # Measure parameter to read
    getter parameter : MeasureParameter

    def initialize(@parameter, @interval)
      super()
    end
  end

  # Task for reading device state
  class CollectorActionTask < CollectorTask
    # Settings action
    getter actionInfo : DeviceAction

    def initialize(@actionInfo)
      super()
    end
  end
end

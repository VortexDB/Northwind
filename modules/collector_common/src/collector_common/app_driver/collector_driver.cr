module Collector
  # Device type
  enum DeviceType
    # Self meter
    Meter,
    # Pipe of device
    Pipe,
    # Pipe group of device
    Group
  end

  # Base device info
  abstract class DeviceInfo
  end

  # Base device info
  class MeterDeviceInfo < DeviceInfo
    DEFAULT_NETWOK_NUMBER = 1

    # Device network number
    getter networkNumber : Int32

    def initialize(@networkNumber = DEFAULT_NETWOK_NUMBER)      
    end
  end

  # Info for passing to protocol driver
  class PipeDeviceInfo < MeterDeviceInfo
    # Pipe number
    getter pipeNumber : Int32

    # Group number
    getter groupNumber : Int32

    def initialize(
      networkNumber = MeterDeviceInfo::DEFAULT_NETWOK_NUMBER,
      @pipeNumber = 0,
      @groupNumber = 0
    )
      super(networkNumber)
    end
  end

  # Base event
  abstract class CollectorDriverEvent
  end

  # Data value from driver
  alias DataValue = Float64 | Time | String

  # Type of TaskDataEvent
  alias DataTaskValue = DataValue | TimedDataValue

  # Value with time
  struct TimedDataValue
    # Date time for value
    getter dateTime : Time

    # Value
    getter value : DataValue

    def initialize(@value, @dateTime)
    end
  end

  # Mixin for response value
  module TaskResponseValue(TValue)
    getter value : TValue
  end

  # Event on task
  abstract class DriverTaskResponseEvent < CollectorDriverEvent
    getter taskId : Int32

    def initialize(@taskId)
    end
  end

  # Event on task with some values from device
  class TaskDataResponseEvent < DriverTaskResponseEvent
    include TaskResponseValue(DataTaskValue)

    def initialize(taskId, @value)
      super(taskId)
    end
  end

  # Response event on time read
  class ReadTimeResponseEvent < DriverTaskResponseEvent
    include TaskResponseValue(Time)

    def initialize(taskId, @value)
      super(taskId)
    end
  end

  # Timeout
  class DriverTimeoutEvent < CollectorDriverEvent
  end
  
  # Base collector drver
  abstract class CollectorDriver
    # Registered devices for driver
    class_property registeredDevices = Array(String).new

    # Macro that registers driver for device
    macro registerDevice(deviceClass)
      self.registeredDevices.push({{ deviceClass.stringify }})
    end

    # Register protocol for driver
    macro registerProtocol(protocolClass)
      class_getter protocol = {{ protocolClass }}.new
      def protocol : {{ protocolClass }}
        self.protocol
      end
    end

    # Add tasks for device
    abstract def appendTask(deviceTasks : CollectorDeviceTasks) : Void

    # Listen block sure value
    def listenBlock!
      @listenBlock.not_nil!
    end

    # Listen for driver event
    def listen(&@listenBlock : CollectorDriverEvent -> Void) : Void
    end

    # Notify task event
    def notifyTaskEvent(event : CollectorDriverEvent) : Void
      listenBlock!.call(event)
    end

    # Calc hash
    def hash
      self.class.name.hash
    end

    # Equals
    def ==(other : CollectorDriver)
      hash == other.hash
    end
  end  
end

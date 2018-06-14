require "../common/*"

module Collector
  # Base event
  abstract class CollectorDriverEvent
  end

  # Notifies about task complete
  class TaskCompleteEvent < CollectorDriverEvent
    # Collector task id
    getter taskId : Int32

    def initialize(@taskId)
    end
  end

  # Data value from driver
  alias DataValue = Float64 | Time | String

  # Value with time
  struct TimedDataValue
    # Date time for value
    getter dateTime : Time

    # Value
    getter value : DataValue

    def initialize(@dateTime, @value)
    end
  end

  # Notifies about task data
  class TaskDataEvent < CollectorDriverEvent
    # Collector task id
    getter taskId : Int32

    # Some value
    getter values : DataValue | Array(TimedDataValue)

    def initialize(@taskId, @values)
    end
  end

  # Timeout
  class DriverTimeoutEvent < CollectorDriverEvent
  end

  # Driver with sporadic data
  module CollectorDriverWithSporadic
  end

  # Collector driver that has own channel
  module CollectorDriverWithOwnChannel
    # Open driver channel for route if there are no default channel
    abstract def openChannel(route : DeviceRoute) : Void

    # Close current channel for route
    abstract def closeChannel : Void
  end

  # Simple driver with external default channel
  module CollectorDriverWithExternalChannel
    # Setter of channel
    abstract def channel=(value : TransportChannel)
  end

  # Base collector drver
  abstract class CollectorDriver
    # Add tasks for device
    # For override
    abstract def appendTask(deviceTasks : CollectorDeviceTasks) : Void

    # Notify task complete
    def notifyTaskComplete(taskId : Int32) : Void
      # addEvent(
      #   TaskCompleteEvent.new(taskId)
      # )
    end

    # Notify task complete
    def notifyData(event : TaskDataEvent) : Void
      # addEvent(
      #   TaskDataEvent.new(taskId)
      # )
    end
  end
end

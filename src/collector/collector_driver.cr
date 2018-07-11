require "./protocol"

module Collector
  # Base event
  abstract class CollectorDriverEvent
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
  
  # Base collector drver
  abstract class CollectorDriver    
    # Add tasks for device
    # For override
    abstract def appendTask(deviceTasks : CollectorDeviceTasks) : Void

    def listenBlock!
      @listenBlock.not_nil!
    end

    def listen(&@listenBlock : CollectorDriverEvent -> Void) : Void
    end

    # Notify task complete
    def notifyData(event : TaskDataEvent) : Void
      listenBlock!.call(event)
    end
  end

  # Driver with channel that be created by collector 
  abstract class CollectorDriverWithExternalChannel < CollectorDriver
    # Channel setter
    abstract def channel=(value : TransportChannel)
  end

  # Key for known drivers hash
  struct DriverKey
    getter route : DeviceRoute
    getter protocolName : String

    def initialize(@route, @protocolName)
    end

    def hash
      @route.hash ^ @protocolName.hash
    end

    def ==(other : DriverKey)
      return @route == other.route &&
        @protocolName == other.protocolName
    end
  end

  # Factory to get driver by Device
  abstract class CollectorDriverFactory
    # Known drivers
    class_property knownDrivers = Hash(DriverKey, CollectorDriver).new

    # Get device driver
    def self.get(route : DeviceRoute, protocolName : String) : CollectorDriver
      key = DriverKey.new(route, protocolName)
      res = knownDrivers[key]?
      return res if !res.nil?
      raise NorthwindException.new("No possible driver can be created")
    end
  end
end

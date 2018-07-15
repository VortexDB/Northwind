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
    # TODO: mixin
    macro register(deviceType, protocolType)
      p {{ protocolType }}
      CollectorDriverFactory.knownDrivers[DriverKey.new({{ deviceType }}, {{ protocolType }})] = {{ @type }}

      getter deviceType = {{ deviceType }}      
      getter protocol = {{ protocolType }}.new
    end    

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

    # Calc hash
    def hash
      deviceType.hash ^ protocol.hash
    end

    # Equals
    def ==(other : CollectorDriver)
      hash == other.hash
    end
  end

  # Key for known drivers hash
  struct DriverKey
    # Device type name
    getter deviceType : String

    # Protocol name
    getter protocolType : Protocol.class

    def initialize(@deviceType, @protocolType)
    end

    def hash
      @deviceType.hash ^ @protocolType.name.hash
    end

    def ==(other : DriverKey)
      return @deviceType == other.deviceType &&
        @protocolType == other.protocolType
    end
  end

  # Factory to get driver by Device
  abstract class CollectorDriverFactory
    # Known drivers
    class_property knownDrivers = Hash(DriverKey, CollectorDriver.class).new

    # Cache for drivers
    @@driverCache = Hash(DriverKey, CollectorDriver).new

    # Get device driver
    def self.get(deviceType : String, protocolType : T.class) : CollectorDriver forall T
      key = DriverKey.new(deviceType, protocolType)
      driver = @@driverCache[key]?
      return driver if !driver.nil?

      driverClass = knownDrivers[key]?
      if !driverClass.nil?
        ndriver = driverClass.new
        @@driverCache[key] = ndriver
        return ndriver
      end

      raise NorthwindException.new("No possible driver can be created for DeviceType: #{deviceType} and ProtocolType: #{protocolType}")
    end
  end
end

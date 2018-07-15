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
  
  # Driver protocol mixin
  module CollectorDriverProtocol(TProtocolType)
    macro included
      class_getter protocol = TProtocolType.new      
      def protocol : TProtocolType
        @@protocol
      end
    end
  end

  # Base collector drver
  abstract class CollectorDriver
    # Device types
    class_property deviceTypes = Set(String).new

    macro registerDevice(deviceType)
      @@deviceTypes.add({{ deviceType }})

      CollectorDriverFactory.register(protocol.class, {{ deviceType }}, {{ @type }})
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
      @@deviceTypes.hash ^ protocol.hash
    end

    # Equals
    def ==(other : CollectorDriver)
      hash == other.hash
    end
  end
  
  # Factory to get driver by Device
  abstract class CollectorDriverFactory
    # Known drivers    
    class_property knownDrivers = Hash(Protocol.class, Hash(String, CollectorDriver.class)).new

    # Register device driver
    def self.register(protocolClass : Protocol.class, deviceType : String, driverClass : CollectorDriver.class) : Void
      drivers = knownDrivers[protocolClass]?
      if drivers.nil?
        drivers = Hash(String, CollectorDriver.class).new
        knownDrivers[protocolClass] = drivers
      end

      drivers[deviceType] = driverClass
    end

    # Cache for drivers
    @@driverCache = Hash(Protocol.class, Hash(String, CollectorDriver)).new

    # Get device driver
    def self.get(deviceType : String, protocolType : T.class) : CollectorDriver forall T
      drivers = @@driverCache[protocolType]?
      if drivers
        driver = drivers[deviceType]?
        return driver if !driver.nil?
      end

      drivers = knownDrivers[protocolType]?
      
      if drivers
        driverClass = drivers[deviceType]?
        if driverClass
          driver = driverClass.new
          cacheDrivers = @@driverCache[protocolType]?
          if cacheDrivers.nil?
            cacheDrivers = Hash(String, CollectorDriver).new            
            @@driverCache[protocolType] = cacheDrivers
          end
          cacheDrivers[deviceType] = driver
          return driver
        end
      end

      raise NorthwindException.new("No possible driver can be created for DeviceType: #{deviceType} and ProtocolType: #{protocolType}")
    end
  end
end

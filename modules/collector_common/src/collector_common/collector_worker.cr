module Collector
  include Database

  # Key for hashmap that contains CollectorDriver-s
  class CollectorDriverKey
    # Device name
    getter device : String

    # Protocol name
    getter protocol : String

    def initialize(@device, @protocol)
    end

    # Calc hash
    def hash
      device.hash ^ protocol.hash
    end
  end  

  # Context of collector to transfer it to collector scripts
  abstract class CollectorWorkerContext
    # Get collector driver for device
    abstract def getDriver(device : CollectorDevice) : CollectorDriver
  end

  # Collects data from devices
  class CollectorWorker < CollectorWorkerContext
    # TODO: remove
    @database : DatabaseClient

    # Data collecting scripts
    @scripts : Array(CollectorScript)

    # All devices
    @devices : Set(CollectorDevice)

    # App drivers
    @drivers : Hash(CollectorDriverKey, CollectorDriver)

    # Start collector script
    private def startScript(script : CollectorScript) : Void
      script.start.success do |res|
        result = res.not_nil!
        puts "Complete #{script.name} Execute time: #{result.executeTime}"
        startScript(script)
      end.catch do |e|
        puts "ERROR"
        puts e.inspect_with_backtrace
      end
    end

    def initialize
      @database = DatabaseClient.new
      @scripts = Array(CollectorScript).new
      @devices = Set(CollectorDevice).new
      @drivers = Hash(CollectorDriverKey, CollectorDriver).new
    end

    # Start collector
    def start : Void
      work
    end
    
    # Main work
    def work : Void
      # TODO: subscribe for driver data events (sporadic)
      
      # Start each script and wait events
      @scripts.each do |script|
        startScript(script)
      end
    end

    # Return driver for device
    def getDriver(device : CollectorDevice) : CollectorDriver
      key = CollectorDriverKey.new(device.deviceType, device.protocolType)
      pp key
      return @drivers[key]?
    end

    # Create new script and return it
    def newScript(name : String, schedule : Schedule) : CollectorScript
      script = CollectorScript.new(name, schedule, self, @database)
      @scripts.push(script)
      return script
    end

    # Register driver
    def registerDriver(driver : CollectorDriver.class) : Void
      devs = driver.registeredDevices
      locDriver = driver
      devs.each do |dev|
        protocol = locDriver.protocol.class.name
        driverKey = CollectorDriverKey.new(dev, protocol)
        @drivers[driverKey] = driver.new
      end
    end
  end
end

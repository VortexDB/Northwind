module Collector
  include Database

  # Collects data from devices
  class CollectorWorker
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

    # Register driver
    def registerDriver(driver : CollectorDriver) : Void
    end
  end
end

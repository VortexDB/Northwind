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
    end

    # Start collector
    def start : Void
      init
      work
    end

    def init : Void
      # TODO: load devices, routes from database
      #driver = CollectorDriverFactory.get("Vkt7", "ModbusRtuProtocol")
      route = TcpClientRoute.new("192.168.0.196", 25301)
      # @devices.add(CollectorDevice.new("Vkt7", "ModbusRtuProtocol", route, driver, PipeDataSource.new(2_i64)))

      # driver1 = CollectorDriverFactory.get("Spt96x", SpbusProtocol::SpbusProtocol)
      # @devices.add(CollectorDevice.new("Spt96x", "SpbusProtocol", route, driver1, MeterDataSource.new(1_i64)))
      driver2 = CollectorDriverFactory.get("Vkt7", ModbusProtocol::ModbusRtu::ModbusRtuProtocol)
      @devices.add(CollectorDevice.new("Vkt7", "ModbusRtuProtocol", route, driver2, MeterDataSource.new(2_i64)))

      # Start listen sporadic event data from drivers if driver support sporadic
      #

      # TODO: load scripts
      offset = Time::Span.new(seconds: 0, nanoseconds: 0)
      period = Time::Span.new(seconds: 10 * 1, nanoseconds: 0)
      script = CollectorScript.new(
        "Collect values",
        PeriodicSchedule.new(offset, period),
        @database)

      @devices.each do |device|
        script.addDevice(device)
        script.addDevice(device)
      end

      currentParameter = MeasureParameter.new(
        MeasureType::TEMPERATURE,
        Discret.new(DiscretType::None, -1)
      )

      archiveParameter = MeasureParameter.new(
        MeasureType::ABSOLUTE_PRESSURE,
        Discret.new(DiscretType::Day, 1)
      )

      settingAction = DeviceAction.new(StateType::DateTime, StateAction::Read)

      script.addParameter(currentParameter)
      script.addAction(settingAction)
      @scripts.push(script)
    end

    # Main work
    def work : Void
      # TODO: subscribe for driver data events (sporadic)
      

      # Start each script and wait events
      @scripts.each do |script|
        startScript(script)
      end
    end
  end
end

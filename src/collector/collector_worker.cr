require "../database/*"

module Collector
  include Database

  # Collects data from devices
  class CollectorWorker
    # TODO: remove
    @database : DatabaseClient

    # Data collecting scripts
    @scripts : Array(CollectorScript)

    # Start collector script
    private def startScript(script : CollectorScript) : Void
      script.start.then! do |info|
        puts "Complete #{script.name} Execute time: #{info.executeTime}"
      end.catch do |e|
        puts "ERROR"
        puts e
      end.whenComplete do
        startScript(script)
      end
    end

    def initialize
      @database = DatabaseClient.new
      @scripts = Array(CollectorScript).new
    end

    # Start collector
    def start : Void
      init
      work
    end

    def init : Void
      # TODO: load scripts

      offset = Time::Span.new(seconds: 0, nanoseconds: 0)
      period = Time::Span.new(seconds: 10 * 1, nanoseconds: 0)
      script = CollectorScript.new(
        "Collect values",
        PeriodicSchedule.new(offset, period),
        @database)

      driver = Spt96xDriver::Driver.new
      route = TcpClientRoute.new("192.168.0.196", 25301)
      # Device
      device = CollectorDevice.new(driver, route, ResourceMeterDataSource.new(1_i64))
      script.addDevice(device)
      # Pipe
      device = CollectorDevice.new(driver, route, PipeDataSource.new(2_i64))
      script.addDevice(device)
      parameter = MeasureParameter.new(
        MeasureType::ABSOLUTE_PRESSURE,
        Discret.new(DiscretType::None, -1)
      )
      settingAction = SettingsAction.new(SettingsState::DateTime, StateAction::Read)

      script.addParameter(parameter)
      # script.addAction(settingAction)
      @scripts.push(script)
    end

    # Main work
    def work : Void
      # Start each script and wait events
      @scripts.each do |script|
        startScript(script)
      end
    end
  end
end

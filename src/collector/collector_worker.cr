# Collects data from devices
class CollectorWorker
  # Сценарии
  @scripts = Array(CollectorScript).new

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
      PeriodicSchedule.new(offset, period))

    driver = Spt96xDriver::Driver.new
    route = TcpClientRoute.new("192.168.0.196", 25301)
    device = CollectorDevice.new(driver, route)
    script.addDevice(device)
    parameter = MeasureParameter.new(
      MeasureType::ABSOLUTE_PRESSURE,
      Discret.new(DiscretType::None, -1)
    )
    settingAction = SettingsAction.new(SettingsState::DateTime, StateAction::Read)

    script.addParameter(parameter)
    script.addAction(settingAction)
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

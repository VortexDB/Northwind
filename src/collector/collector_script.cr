require "../common/*"

# Info about completion
class ScriptCompleteInfo
  # Execution time
  getter executeTime : Time::Span

  def initialize(@executeTime)
  end
end

# Collector script
class CollectorScript
  # Period of timer to check schedule
  PERIOD = 10

  # Deep of collect in days
  DEFAULT_DEEP = 3

  # Driver no any event timeout
  # Guards from driver hangs
  DRIVER_SILENCE_TIMEOUT = 1 * 60

  # Schedule of script
  @schedule : Schedule

  # Devices to request
  @devices : Set(CollectorDevice)

  # Parameters to collect
  @parameters : Set(MeasureParameter)

  # Actions
  @actions : Set(SettingsAction)

  # To notify script execution completed
  @executeCompleter : Completer(ScriptCompleteInfo)?

  def executeCompleter!
    @executeCompleter.not_nil!
  end

  # Deep of requests
  property deep : Int32 = DEFAULT_DEEP

  # Is script working
  getter isWorking : Bool = false

  # Name of script
  getter name : String

  # Connect and return transport channel
  private def getChannelByRoute(route : DeviceRoute) : TransportChannel?
    channel = TransportChannel.create(route)
    channel.open
    return channel
  end

  # Collect data from driver for it's devices
  private def collectByDriver(driver : CollectorDriver, driverDevices : Array(CollectorDevice))
    now = Time.now
    startTime = now + Time::Span.new(@deep, 0, 0)
    endTime = now
    interval = DateInterval.new(startTime, endTime)
    tasks = Array(CollectorTask).new

    # Append task in other fiber
    driverDevices.each do |device|
      @actions.each do |act|
        tasks << CollectorActionTask.new(act)
      end

      @parameters.each do |par|
        tasks << CollectorDataTask.new(par, interval)
      end
      
      begin
        driver.appendTask(CollectorDeviceTasks.new(device, tasks))
      rescue
        # TODO: notify error
      end
    end
  end

  # Start schedule of script
  private def startSchedule : Void
    return unless @isWorking

    nextStart = @schedule.nextStart
    # TODO: notifyMessage
    puts "Name: #{@name} Next start: #{nextStart}"

    Future.delayed(nextStart) do
      startTime = Time.monotonic
      startCollect
      executeTime = Time.monotonic - startTime
      # Wait for complete
      executeCompleter!.complete(ScriptCompleteInfo.new(
        executeTime: executeTime
      ))
    end.catch do |e|
      # TODO notify error
      # executeCompleter!.completeError(e)
    end
  end

  # Start collect from all devices in scripts
  private def startCollect : Void
    puts "Start collect"
    puts "Devices: #{@devices.size}"
    puts "Parameters: #{@parameters.size}"
    puts "Deep: #{@deep}"

    futures = Array(Future(Void)).new

    @devices.each.group_by { |x| x.route }.each do |route, routeDevices|
      futures << Future(Void).new do
        # Get a channel for route
        channel = getChannelByRoute(route)
        next if channel.nil?
        routeDevices.group_by { |x| x.driver }.each do |driver, driverDevices|
          driver.channel = channel
          collectByDriver(driver, driverDevices)
        end

        channel.close
      end
    end
    
    Future.waitAll(futures)
  end

  # Start work
  def start : Future
    @executeCompleter = Completer(ScriptCompleteInfo).new

    @isWorking = true
    startSchedule

    return executeCompleter!.future
  end

  def initialize(@name, @schedule)
    @devices = Set(CollectorDevice).new
    @parameters = Set(MeasureParameter).new
    @actions = Set(SettingsAction).new
  end

  # Add device to script
  def addDevice(device : CollectorDevice) : Void
    @devices.add(device)
  end

  # Add parameter
  def addParameter(parameter : MeasureParameter) : Void
    @parameters.add(parameter)
  end

  # Add action
  def addAction(action : SettingsAction) : Void
    @actions.add(action)
  end
end

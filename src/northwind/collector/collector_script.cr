require "../common/*"

# Event of collector script
class CollectorScriptEvent
end

# Collector script
class CollectorScript < AsyncWorker(CollectorScriptEvent)
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

  # Deep of requests
  property deep : Int32 = DEFAULT_DEEP

  # Is script working
  getter isWorking : Bool = false

  # Name of script
  getter name : String

  # Connect and return transport channel
  private def getChannelByRoute(route : DeviceRoute) : TransportChannel?
    begin
      channel = TransportChannel.create(route)
      channel.open
      return channel
    rescue e : Exception
      puts e
    end
  end

  # Block thread and process driver events
  private def processDriverEvents(driver : CollectorDriver, tasks : Array(CollectorTask)) : Void
    # Listen for driver events
    iswork = true
    while iswork
      driver.listenEvent(DRIVER_SILENCE_TIMEOUT) do |event|
        case event
        when DriverTimeoutEvent
          puts "Driver timeout"
          iswork = false
        when TaskDataEvent
          puts "Task data: #{event.taskId}"        
        when TaskCompleteEvent
          puts "Task completed: #{event.taskId}"
        else
          raise NorthwindException.new("Unknown driver event")
        end
      end
    end
  end

  # Collect data from driver for it's devices
  private def collectByDriver(driver : CollectorDriver, driverDevices : Array(CollectorDevice))
    now = Time.now
    startTime = now + Time::Span.new(@deep, 0, 0)
    endTime = now
    interval = DateInterval.new(startTime, endTime)
    tasks = Array(CollectorTask).new    

    spawn do
      begin
        driverDevices.each do |device|
          @actions.each do |act|
            tasks << CollectorActionTask.new(act)
          end

          @parameters.each do |par|
            tasks << CollectorDataTask.new(par, interval)
          end

          driver.appendTask(CollectorDeviceTasks.new(device, tasks))
        end
      rescue e : Exception
        # TODO: handle exception
        puts e
      end
    end

    processDriverEvents(driver, tasks)
  end

  # Start schedule of script
  private def startSchedule : Void
    return unless @isWorking

    nextStart = @schedule.nextStart
    puts "Name: #{@name} Next start: #{nextStart}"
    delay(nextStart) do
      begin
        startCollect
      rescue e : Exception
        puts e
      ensure
        startSchedule
      end
    end
  end

  # Start collect from all devices in scripts
  private def startCollect : Void
    puts "Start collect"
    puts "Devices: #{@devices.size}"
    puts "Parameters: #{@parameters.size}"
    puts "Deep: #{@deep}"

    bench = Benchmark.realtime do
      @devices.each.group_by { |x| x.route }.each do |route, routeDevices|
        # Get a channel for route
        channel = getChannelByRoute(route)
        next if channel.nil?
        routeDevices.group_by { |x| x.driver }.each do |driver, driverDevices|
          begin
            driver.channel = channel
            collectByDriver(driver, driverDevices)
          rescue e : Exception
            puts e
          end
        end

        channel.close
      end
    end
    puts "Collect complete #{bench}"
  end

  # Main work
  protected def work : Void
    startSchedule
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
# Info for passing to protocol driver
class SpbusDeviceInfo
  # Device using address
  getter usingAddress : Bool

  # Address of device
  getter destAddress : UInt8

  # Self address
  getter serverAddress : UInt8

  def initialize(
    @usingAddress = false,
    @destAddress = 0_u8,
    @serverAddress = 0_u8
  )
  end
end

# Driver for Logica SPT96x
class Spt96xDriver < CollectorDriver
  include CollectorDriverWithExternalChannel

  # Protocol
  @protocol = SpbusProtocol.new

  # Set transport channel
  def channel=(value : TransportChannel)
    @protocol.channel = value
  end

  def initialize
  end

  # Get device info from device
  private def getDeviceInfo(device : CollectorDevice) : SpbusDeviceInfo
    return SpbusDeviceInfo.new
  end

  # Prepare and execute read action
  private def executeReadAction(deviceInfo : SpbusDeviceInfo, action : CollectorActionTask) : Void
    case action.actionInfo.state
    when SettingsState::DateTime
      SpbusTimeReader.new(@protocol) do |time|
        notifyData(action.taskId)
      end
    else
      raise NorthwindException.new("Unknown read action")
    end
  end

  # Prepare and execute write action
  private def executeWriteAction(deviceInfo : SpbusDeviceInfo, action : CollectorActionTask) : Void
  end

  # Execute actions
  private def executeActions(deviceInfo : SpbusDeviceInfo, tasks : Array(CollectorActionTask)) : Void
    tasks.each do |task|
      case task.actionInfo.action
      when StateAction::Read
        executeReadAction(deviceInfo, task)
      when StateAction::Write
        executeWriteAction(deviceInfo, task)
      else
        raise NorthwindException.new("Unknown action")
      end
    end
  end

  # Add device task
  def appendTask(deviceTasks : CollectorDeviceTasks) : Void
    actions = deviceTasks.tasks.compact_map do |x|
      x if x.is_a?(CollectorActionTask)
    end

    deviceInfo = getDeviceInfo(deviceTasks.device)

    executeActions(deviceInfo, actions)
  end
end

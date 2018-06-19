require "../../protocols/spbus_protocol/**"

module Spt96xDriver
  include Collector
  include SpbusProtocol

  # Driver for Logica SPT96x
  class Driver < CollectorDriver
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
    private def getDeviceInfo(device : CollectorDevice) : DeviceInfo
      case device.dataSource
      when ResourceMeterDataSource
        return DeviceInfo.new
      when PipeDataSource
        # TODO: pipe number
        return DeviceInfo.new(DeviceType::Pipe, 1)
      else
        raise NorthwindException.new("Unknown data source")
      end
    end

    # Prepare and execute read action
    private def executeReadAction(deviceInfo : DeviceInfo, action : CollectorActionTask) : Void
      case action.actionInfo.state
      when SettingsState::DateTime
        TimeReader.new(@protocol) do |time|
          # notifyData(action.taskId)
        end
      else
        raise NorthwindException.new("Unknown read action")
      end
    end

    # Prepare and execute write action
    private def executeWriteAction(deviceInfo : DeviceInfo, action : CollectorActionTask) : Void
    end

    # Execute actions
    private def executeActions(deviceInfo : DeviceInfo, tasks : Array(CollectorActionTask)) : Void
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

    # Execute current value reading
    private def executeCurrentValues(deviceInfo : DeviceInfo, tasks : Array(CollectorDataTask)) : Void
      return if (deviceInfo.deviceType != DeviceType::Pipe && deviceInfo.deviceType != DeviceType::Group)

      tastToRequest = Hash(RequestParameter, CollectorDataTask).new

      reader = ValueReader.new
      tasks.each do |task|
        parameter = RequestParameter.fromChannelCurrent(deviceInfo.pipeNumber, task.parameter)
        tastToRequest[parameter] = task
        reader.addParameter(parameter)
      end

      reader.execute(@protocol) do |response|
        task = tastToRequest[response.request]?
        next if task.nil?
        notifyData(TaskDataEvent.new(task.taskId, response.value))
      end
    end

    # Execute archive reading
    private def executeArchive(deviceInfo : DeviceInfo, tasks : Array(CollectorDataTask)) : Void
    end

    # Execute device task
    def appendTask(deviceTasks : CollectorDeviceTasks) : Void
      deviceInfo = getDeviceInfo(deviceTasks.device)

      if deviceInfo.deviceType != DeviceType::Meter
        actions = deviceTasks.tasks.compact_map do |x|
          x if x.is_a?(CollectorActionTask)
        end

        executeActions(deviceInfo, actions) if !actions.empty?
      end

      if (deviceInfo.deviceType != DeviceType::Pipe && deviceInfo.deviceType != DeviceType::Group)
        current = Array(CollectorDataTask).new
        archive = Array(CollectorDataTask).new

        deviceTasks.tasks.each do |task|
          case task
          when CollectorDataTask
            if task.parameter.discret == DiscretType::None
              current << task
            else
              archive << task
            end
          else
          end
        end

        executeCurrentValues(deviceInfo, current) if !current.empty?
        executeArchive(deviceInfo, archive) if !current.empty?
      end
    end
  end
end

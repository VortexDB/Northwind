require "./collector_driver"

module Collector
  # Base driver for smart meters
  abstract class CollectorMeterDriver < CollectorDriver
    # Current device info
    getter! deviceInfo : MeterDeviceInfo?

    # Execute actions
    private def executeActions(tasks : Array(CollectorActionTask)) : Void
      tasks.each do |task|
        executeAction(task)
      end
    end

    # Return device info from device
    # Can be overrided for creating own device info
    protected def getDeviceInfo(device : CollectorDevice) : MeterDeviceInfo
      # TODO: Get this information from database
      case device.dataSource
      when PipeDataSource
        return PipeDeviceInfo.new(1, 1)
      when MeterDataSource
        return MeterDeviceInfo.new
      else
        raise NorthwindException.new("Unknown device type")
      end
    end

    # Execute before all task execution for device
    def executeBefore : Void
    end

    # Execute after all task execution for device
    def executeAfter : Void
    end

    # Process execute action. Virtual
    def executeAction(action : CollectorActionTask) : Void
    end

    # Process read current values. Virtual
    def executeCurrentValues(tasks : Array(CollectorDataTask)) : Void
    end

    # Process read archive. Virtual
    def executeArchive(tasks : Array(CollectorDataTask)) : Void
    end

    # Execute device task
    def appendTask(deviceTasks : CollectorDeviceTasks) : Void
      deviceInfo = getDeviceInfo(deviceTasks.device)

      actions = deviceTasks.tasks.compact_map do |x|
        x if x.is_a?(CollectorActionTask)
      end

      current = Array(CollectorDataTask).new
      archive = Array(CollectorDataTask).new

      deviceTasks.tasks.each do |task|
        case task
        when CollectorDataTask
          if task.parameter.discret.discretType == DiscretType::None
            current << task
          else
            archive << task
          end
        else
        end
      end

      executeBefore
      executeActions(actions) if !actions.empty?
      executeCurrentValues(current) if !current.empty?
      executeArchive(archive) if !current.empty?
      executeAfter
    end
  end
end

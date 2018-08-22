module Vkt7Driver
  include Collector
  include ModbusProtocol::ModbusRtu

  # Driver for VKT-7 heat meter
  class Vkt7ModbusRtuDriver < CollectorMeterDriver
    include CollectorDriverProtocol(ModbusRtuProtocol)

    registerDevice("Vkt7")

    # Process read action. Virtual
    def executeReadAction(action : CollectorActionTask) : Void
      case action.actionInfo.state
      when StateType::DateTime
        TimeReader.new(deviceInfo, protocol) do |time|
          notifyTaskEvent(ReadTimeResponseEvent.new(
            action.taskId,
            time
          ))
        end
      else
        raise NorthwindException.new("Unknown read action")
      end
    end

    # Process current value requests
    def executeCurrentValues(tasks : Array(CollectorDataTask)) : Void
      case deviceInfo
      when PipeDeviceInfo
        valueReader = ValueReader.new(deviceInfo, protocol)
        tasks.each do |task|
          valueReader.addParameter(task.parameter)
        end

        valueReader.execute do |value|
          tasks.each do |task|
            if task.parameter == value.measureParameter
              notifyTaskEvent(TaskDataResponseEvent.new(
                task.taskId,
                value.value
              ))
            end
          end
        end
      end
    end

    # Process read archive
    def executeArchive(tasks : Array(CollectorDataTask)) : Void
      case deviceInfo
      when PipeDeviceInfo
        tasks.group_by { |x| MeasureParameterHelper.getProfileType(x.parameter) }.each do |group|
          
        end

        # profileReader = ProfileReader.new
      end
    end
  end
end

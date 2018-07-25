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
        valueReader = ValueReader.new        
        tasks.each do |task|
          valueReader.addParameter
        end
      end
    end
  end
end

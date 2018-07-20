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
        reader = TimeReader.new(deviceInfo, protocol)
        reader.execute do |time|
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
      tasks.each do |task|
      end
    end
  end
end

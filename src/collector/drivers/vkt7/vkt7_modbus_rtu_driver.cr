module Vkt7Driver
  include Collector
  include ModbusProtocol::ModbusRtu

  # Driver for VKT-7 heat meter
  class Vkt7ModbusRtuDriver < CollectorMeterDriver
    include CollectorDriverProtocol(ModbusRtuProtocol)
    include CollectorPipeMeterDriver

    registerDevice("Vkt7")

    # Process read action. Virtual
    def executeReadAction(action : CollectorActionTask) : Void
      case action.actionInfo.state
      when StateType::DateTime
        # TimeReader.new(protocol) do |time|
        #   # notifyData(action.taskId)
        # end
        res = protocol.sendRequestWithResponse(ReadHoldingRegistersRequest.new(1_u8, 0x3FFB_u16, 0_u16))
        pp res
      else
        raise NorthwindException.new("Unknown read action")
      end      
    end
  end
end

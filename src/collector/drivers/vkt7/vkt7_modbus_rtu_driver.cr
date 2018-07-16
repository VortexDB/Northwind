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
        protocol.sendRequestWithResponse(ReadHoldingRegistersRequest.new(1_u8, 0x3FFE_u16, 0_u16))
      else
        raise NorthwindException.new("Unknown read action")
      end      
    end
  end
end

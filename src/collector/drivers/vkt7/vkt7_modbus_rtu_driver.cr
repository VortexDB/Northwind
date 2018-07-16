module Vkt7Driver
  include Collector
  include ModbusProtocol::ModbusRtu

  # Driver for VKT-7 heat meter
  class Vkt7ModbusRtuDriver < PipeMeterDriver
    include CollectorDriverProtocol(ModbusRtuProtocol)

    registerDevice("Vkt7")

    # Execute device task
    def appendTask(deviceTasks : CollectorDeviceTasks) : Void
      protocol.sendRequestWithResponse(ReadHoldingRegistersRequest.new(0_u16, 0_u16))
    end
  end
end

require "collector_common"

module VktDriver
  # Executer context for Vkt driver
  class VktExecuterContext < Collector::ExecutionContext
    # Vkt meter model
    getter meterModel : VktModel

    # Modbus protocol
    getter modbusProtocol : ModbusProtocol::ModbusProtocol    

    def initialize(deviceInfo, @modbusProtocol, @meterModel)
      super(deviceInfo, modbusProtocol)
    end
  end
end

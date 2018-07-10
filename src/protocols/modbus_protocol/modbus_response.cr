module ModbusProtocol
    include Collector

    # Base modbus response
    abstract class ModbusResponse < ProtocolResponse
    end
end
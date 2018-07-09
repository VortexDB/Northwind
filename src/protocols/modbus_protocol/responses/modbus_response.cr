module ModbusProtocol
    include Collector

    # Base modbus response
    abstract class ModbusResponse < ProtocolRequest
    end
end
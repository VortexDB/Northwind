module ModbusProtocol
    include Collector

    # Base modbus request
    abstract class ModbusRequest < ProtocolRequest
    end    
end
module ModbusProtocol
  include Collector
  
  # Base modbus protocol
  abstract class ModbusProtocol < ResponseRequestProtocol
  end
end

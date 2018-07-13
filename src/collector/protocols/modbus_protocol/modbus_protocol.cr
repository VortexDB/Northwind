module ModbusProtocol
  include Collector

  # Base modbus protocol
  abstract class ModbusProtocol < Protocol
  end
end

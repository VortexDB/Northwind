module Vkt7Driver
  # Read time
  class ValueReader < DriverCurrentValueReader(MeterDeviceInfo, ModbusRtuProtocol)
    # Execute and iterate values in block
    def execute(&block : ValueData -> _)
    end
  end
end

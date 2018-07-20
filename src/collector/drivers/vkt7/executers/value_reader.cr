module Vkt7Driver
  # Read time
  class ValueReader < DriverCurrentValueReader(MeterDeviceInfo, ModbusRtuProtocol)
    @requestParameters = Set(RequestParameter).new

    # Add parameter for reading
    def addParameter()
    end

    # Execute and iterate values in block
    def execute(&block : ValueData -> _)    
      infoReader = ItemInfoReader.new(@requestParameters)
      itemsInfo = infoReader.execute

      
    end
  end
end

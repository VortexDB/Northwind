require "./requests/**"
require "./responses/**"

module ModbusProtocol
  include Collector

  # Modbus protocol
  class ModbusProtocol < Protocol(ModbusRequest, ModbusResponse)
    # Send applied data and wait request
    def sendRequestWithResponse(protocolData : TRequest) : TResponse
      frame = protocolData.getData
      begin
        channel!.write(frame)
        
        # TODO: process channel exceptions
      rescue e : Exception
        # Process unhandled exceptions
        puts e
      end

      return ProtocolResponse.new
    end
  end
end

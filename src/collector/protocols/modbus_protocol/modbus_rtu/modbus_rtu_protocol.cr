module ModbusProtocol::ModbusRtu
  include Collector

  # Modbus RTU protocol
  class ModbusRtuProtocol < ModbusProtocol
    # Register protocol
    register()

    # Send applied data and wait request
    def sendRequestWithResponse(request : ProtocolRequest) : ProtocolResponse
      frame = request.as(ModbusRtuRequest).getData
      begin
        channel!.write(frame)
        
        # TODO: process channel exceptions
      rescue e : Exception
        # Process unhandled exceptions
        puts e
      end

      return ModbusRtuResponse.new
    end
  end
end

require "./modbus_rtu_request"
require "./modbus_rtu_response"

module ModbusProtocol::ModbusRtu
  include Collector

  # Modbus RTU protocol
  class ModbusRtuProtocol < ModbusProtocol
    include ProtocolChannel(BinaryTransportChannel)
    include ResponseRequestProtocol(ModbusRtuRequest, ModbusRtuResponse)

    # Send applied data and wait request
    def sendRequestWithResponse(request : ModbusRtuRequest) : ModbusRtuResponse
      frame = request.getData
      begin
        channel!.write(frame)
      rescue e : Exception
        # Process unhandled exceptions
        puts e.inspect_with_backtrace
      end

      return ModbusRtuResponse.new
    end
  end
end

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
        fullFrame = IO::Memory.new
        fullFrame.write_bytes(0xFFFF_u16)

        payload = IO::Memory.new
        payload.write_bytes(request.networkAddress)
        payload.write_bytes(request.functionId)
        payload.write(frame)

        payloadBytes = payload.to_slice
        fullFrame.write(payloadBytes)
        
        crc = ModbusRtuCrcHelper.calcCrc(payloadBytes)
        fullFrame.write_bytes(crc, IO::ByteFormat::BigEndian)
        
        channel!.write(fullFrame.to_slice)  

        loop do
          packet = channel!.read
        end

      rescue e : Exception
        # Process unhandled exceptions
        puts e.inspect_with_backtrace
      end

      return ModbusRtuResponse.new
    end
  end
end

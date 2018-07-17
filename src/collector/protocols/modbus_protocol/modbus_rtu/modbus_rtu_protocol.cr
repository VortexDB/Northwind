require "./modbus_rtu_request"
require "./modbus_rtu_response"

module ModbusProtocol::ModbusRtu
  include Collector

  # Modbus RTU protocol
  class ModbusRtuProtocol < ModbusProtocol
    include ProtocolChannel(BinaryTransportChannel)
    include ResponseRequestProtocol(ModbusRtuRequest, ModbusRtuResponse) 

    HEADER_SIZE = 2 # Network + FunctionId
    MIN_PACKET_SIZE = HEADER_SIZE + 2 # Network + FunctionId + Crc16    

    # Get answer length
    private def getAnswerLength(functionId : UInt8, buffer : IO::Memory) : Int32
      case functionId
      when ReadHoldingRegistersRequest::FUNCTION_ID
        buffer.read_at(2, 1) do |reader|
          lenByte = reader.read_byte
          return lenByte.to_i32 if lenByte          
        end              
      end

      return -1
    end

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

        buffer = IO::Memory.new
        fullSize = 0
        lengthRead = false
        network = 0_u8
        functionId = 0_u8

        answerLength = -1

        loop do
          begin
            # Try get packet by length
            data = channel!.read
            fullSize = fullSize + data.size
            buffer.write(data)
            if !lengthRead && fullSize >= HEADER_SIZE              
              buffer.read_at(0, 2) do |readBuff|
                network = readBuff.read_byte
                functionId = readBuff.read_byte
              end
              if functionId
                answerLength = getAnswerLength(functionId, buffer)
              end
              lengthRead = true
            end

            next if answerLength < 1
            break if fullSize - MIN_PACKET_SIZE >= answerLength
          rescue e : IO::Timeout
            # Get packet by timeout            
            break
          end
        end
        
        if buffer.size <= MIN_PACKET_SIZE
          raise NorthwindException.new("Bad response")
        end

        if network.nil? || functionId.nil?
          raise NorthwindException.new("Bad response")
        end

        buffer.rewind
        crcData = Bytes.new(buffer.size - 2)
        buffer.read(crcData)
        
        buffer.seek(2)
        data = Bytes.new(buffer.size - MIN_PACKET_SIZE)        
        buffer.read(data)        
        crc = buffer.read_bytes(UInt16, IO::ByteFormat::BigEndian)
        calcCrc = ModbusRtuCrcHelper.calcCrc(crcData)
        
        if crc != calcCrc
          raise NorthwindException.new("Wrong crc")
        end
        
        return ModbusRtuResponse.new(network, functionId, data)

      rescue e : NorthwindException
        raise e
      rescue e : Exception
        # Process unhandled exceptions
        puts e.inspect_with_backtrace
      end
      
      raise NorthwindException.new("Bad response")
    end
  end
end

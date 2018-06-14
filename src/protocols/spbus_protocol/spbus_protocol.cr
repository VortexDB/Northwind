module SpbusProtocol
  include Collector

  # Protocol of Logica devices
  class SpbusProtocol < Protocol
    # Add DLE array to IO
    private def addDleArray(io : IO, data : Bytes) : Void
      data.each do |x|
        if x == SpbusSpecialBytes::DLE_BYTE
          io.write_bytes(SpbusSpecialBytes::DLE_BYTE)
        else
          io.write_bytes(x)
        end
      end
    end

    # Create spbus protocol frame
    private def createFrame(protocolData : SpbusProtocolRequest) : Bytes
      binary = IO::Memory.new
      binary.write_bytes(SpbusSpecialBytes::DLE_BYTE)
      binary.write_bytes(SpbusSpecialBytes::SOH_BYTE)

      crcArray = IO::Memory.new

      if protocolData.usingAddress
        crcArray.write_bytes(protocolData.destAddress)
        crcArray.write_bytes(protocolData.serverAddress)
      end

      crcArray.write_bytes(SpbusSpecialBytes::DLE_BYTE)
      crcArray.write_bytes(SpbusSpecialBytes::ISI_BYTE)
      crcArray.write_bytes(protocolData.function)
      crcArray.write_bytes(SpbusSpecialBytes::DLE_BYTE)
      crcArray.write_bytes(SpbusSpecialBytes::STX_BYTE)
      addDleArray(crcArray, protocolData.data)
      crcArray.write_bytes(SpbusSpecialBytes::DLE_BYTE)
      crcArray.write_bytes(SpbusSpecialBytes::ETX_BYTE)
      crcData = crcArray.to_slice
      crc = SpbusCrcHelper.calcCrc(crcData)
      binary.write(crcData)
      binary.write_bytes(crc, IO::ByteFormat::BigEndian)
      return binary.to_slice
    end

    # Send applied data and wait request
    def sendRequestWithResponse(protocolData : ProtocolRequest) : ProtocolResponse
      frame = createFrame(protocolData.as(SpbusProtocolRequest))
      begin
        channel!.write(frame)
        unpacker = SpbusFrameUnpacker.new
        loop do
          packet = channel!.read # TODO: read timeout
          response = unpacker.addBytes(packet[0], packet[1])
          return response if !response.nil?
        end

        # TODO: process channel exceptions
      rescue e : Exception
        # Process unhandled exceptions
        puts e
      end

      raise NorthwindException.new("Protocol read error")
    end
  end
end

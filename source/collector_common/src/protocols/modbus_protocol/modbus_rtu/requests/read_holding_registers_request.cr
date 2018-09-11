module ModbusProtocol::ModbusRtu
  # Base modbus request
  class ReadHoldingRegistersRequest < ModbusRtuRequest
    register(0x03)

    # Start address to read
    getter address : UInt16

    # Length to read
    getter length : UInt16

    def initialize(networkAddress, @address, @length)
      super(networkAddress)
    end

    # Return binary data of request
    def getData : Bytes
      res = IO::Memory.new
      res.write_bytes(address, IO::ByteFormat::BigEndian)
      res.write_bytes(length, IO::ByteFormat::BigEndian)
      return res.to_slice
    end
  end
end

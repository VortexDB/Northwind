module ModbusProtocol::ModbusRtu
    # Base modbus request
    class PresetMultipleRegistersRequest < ModbusRtuRequest
        register(0x10)

        # Response length
        RESPONSE_LENGTH = 2

        # Start address to read
        getter address : UInt16

        # Length to read
        getter length : UInt16

        # Data to write
        getter data : Bytes

        def initialize(networkAddress, @address, @length, @data, knownLength = RESPONSE_LENGTH)
            super(networkAddress, knownLength)
        end

        # Return binary data of request
        def getData : Bytes
            res = IO::Memory.new
            res.write_bytes(address, IO::ByteFormat::BigEndian)
            res.write_bytes(length, IO::ByteFormat::BigEndian)
            res.write(data)
            return res.to_slice
        end
    end
end
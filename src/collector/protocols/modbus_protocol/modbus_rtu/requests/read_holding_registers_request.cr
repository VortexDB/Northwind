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

        # Return answer length. If length == 0 then answer length is unknown
        # Only data, no header and crc
        def getAnswerLength : Int32
            return -1 if length == 0
            return 1 + (1 + length) * 2
        end
    end
end
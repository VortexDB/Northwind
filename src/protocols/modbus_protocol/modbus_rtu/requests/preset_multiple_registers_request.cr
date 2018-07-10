module ModbusProtocol::ModbusRtu
    # Base modbus request
    class PresetMultipleRegistersRequest < ModbusRtuRequest
        register(0x10)

        # Start address to read
        getter address : UInt16

        # Length to read
        getter length : UInt16

        # Data to write
        getter data : Bytes

        def initialize(@address, @length, @data)
        end

        # Return binary data of request
        def getData : Bytes
            res = Bytes.new
            res.write_bytes(address)
            res.write_bytes(length)
            res.write_bytes(data)
            return res
        end

        # Return answer length or -1 of it's unknown
        def getAnswerLength : Int32
            return -1 if length == 0
            return 1 + (1 + length) * 2
        end
    end
end
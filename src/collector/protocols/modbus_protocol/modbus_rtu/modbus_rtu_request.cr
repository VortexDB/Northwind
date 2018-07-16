module ModbusProtocol::ModbusRtu
  include Collector

  # Base modbus rtu request
  abstract class ModbusRtuRequest < ModbusRequest
    macro register(id)
        FUNCTION_ID = {{ id }}.to_u8

        def functionId : UInt8
            return FUNCTION_ID
        end
    end

    # Address of device
    getter networkAddress : UInt8

    def initialize(@networkAddress)
    end

    # Return function ID
    abstract def functionId : UInt8

    # Return binary data of request
    abstract def getData : Bytes

    # Return answer length or -1 of it's unknown
    def getAnswerLength : Int32
      return -1
    end
  end
end

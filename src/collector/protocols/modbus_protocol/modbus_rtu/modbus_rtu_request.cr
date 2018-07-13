module ModbusProtocol::ModbusRtu
    include Collector

    # Base modbus rtu request
    abstract class ModbusRtuRequest < ModbusRequest
        macro register(id)
            FUNCTION_ID = id

            def functionId : Int32
                return FUNCTION_ID
            end 
        end

        # Return function ID
        abstract def functionId : Int32

        # Return binary data of request
        abstract def getData : Bytes

        # Return answer length or -1 of it's unknown
        def getAnswerLength : Int32
            return -1
        end
    end
end
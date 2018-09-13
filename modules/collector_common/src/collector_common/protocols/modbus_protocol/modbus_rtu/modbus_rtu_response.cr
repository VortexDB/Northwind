module ModbusProtocol::ModbusRtu
    include Collector

    # Base modbus rtu response
    class ModbusRtuResponse < ModbusResponse
        # Device address in network
        getter network : UInt8
        
        # Function id
        getter functionId : UInt8

        # Received data
        getter data : Bytes

        def initialize(@network, @functionId, @data)
        end
    end
end
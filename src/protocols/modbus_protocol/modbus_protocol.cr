module ModbusProtocol
    include Collector

    # Modbus protocol
    class ModbusProtocol < Protocol
        # Send applied data and wait request
        def sendRequestWithResponse(protocolData : ProtocolRequest) : ProtocolResponse
            return ProtocolResponse.new
        end
    end
end
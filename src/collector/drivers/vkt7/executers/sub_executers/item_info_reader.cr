module Vkt7Driver
    # Read Vkt7 item info
    class ItemInfoReader < BaseExecuter(ParameterInfoWithData)
        # Parameters to get data
        @requests = Set(ParameterInfo).new

        # Add item to read info
        def addItemType(parameter : ParameterInfo) : Void
            @requests.add(parameter)
        end

        # Execute and iterate values in block
        def execute(&block : ParameterInfoWithData -> Void) : Void
            network = @deviceInfo.networkNumber.to_u8
            # Select data type
            response = @protocol.sendRequestWithResponse(PresetMultipleRegistersRequest.new(
                network, Vkt7StartAddress::WriteDataType, 0_u16, Bytes[0x02, Vkt7DataType::Property, 0x00]))
            # Select items
            # response = @protocol.sendRequestWithResponse(PresetMultipleRegistersRequest.new(network, Vkt7StartAddress::WriteDataType, 0_u16))
            # Read values
            #response = @protocol.sendRequestWithResponse(ReadHoldingRegistersRequest.new(network, Vkt7StartAddress::TimeAddress, 0_u16))
        end
    end
end
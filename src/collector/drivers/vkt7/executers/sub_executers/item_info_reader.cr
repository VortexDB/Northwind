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
            # Select item
            # Select item types
            #response = @protocol.sendRequestWithResponse(ReadHoldingRegistersRequest.new(network, Vkt7StartAddress::TimeAddress, 0_u16))
        end
    end
end
module Vkt7Driver
    # Select items in Vkt7
    class SelectItemsExecuter < BaseExecuter(Bool)
        # Parameters to get data
        @requests = Set(ElementRequest).new

        # Add item to read info
        def addItemType(parameter : ElementRequest) : Void
            @requests.add(parameter)
        end

        # Execute and iterate values in block
        def execute(&block : Bool -> Void) : Void
            network = @deviceInfo.networkNumber.to_u8
            binary = IO::Memory.new
            binary.write_bytes((@requests.size * 6).to_u8)
            @requests.each do |request|
                binary.write_bytes((0x40000000 + request.itemId).to_i32)
                binary.write_bytes(request.size)
            end

            response = @protocol.sendRequestWithResponse(PresetMultipleRegistersRequest.new(
                network, Vkt7StartAddress::WriteElementTypes, 0_u16, binary.to_slice))

            yield true
        end
    end
end
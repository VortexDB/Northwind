module VktDriver
    # Read Vkt7 item value
    # class ItemValueReader < BaseExecuter(Vkt7ElementData)
    #     # All elements
    #     getter elements = Set(ElementRequest).new

    #     # Meter version
    #     @version : UInt8

    #     def initialize(deviceInfo : MeterDeviceInfo, protocol : ModbusRtuProtocol, @version : UInt8)
    #         super(deviceInfo, protocol)
    #     end

    #     # Add element type
    #     def addItemType(element : ElementRequest) : Void
    #         @elements.add(element)
    #     end        

    #     # Execute and iterate values in block
    #     def execute(&block : Vkt7ElementData -> Void) : Void
    #         network = @deviceInfo.networkNumber.to_u8

    #         # Read values
    #         response = @protocol.sendRequestWithResponse(ReadHoldingRegistersRequest.new(network, Vkt7StartAddress::ReadDataAddress, 0_u16))
    #         binary = IO::Memory.new(response.data, false)
    #         binary.seek(1)  # Ignore data length
    #         elements.each do |element|
    #             size = element.size
    #             data : (Float64 | String)? = nil

    #             case size
    #             when 1
    #                 data = binary.read_bytes(UInt8).to_f64                    
    #             when 2
    #                 data = binary.read_bytes(UInt16).to_f64                    
    #             when 4
    #                 data = binary.read_bytes(UInt32).to_f64
    #             when 7
    #                 case @version
    #                 when CommonExecuter::VERSION_ZERO
    #                     bytes = Bytes.new(7)
    #                     binary.read(bytes)
    #                     data = String.new(bytes, "cp1252").strip
    #                 when CommonExecuter::VERSION_ONE
    #                     strSize = binary.read_bytes(UInt16)
    #                     bytes = Bytes.new(strSize)
    #                     binary.read(bytes)
    #                     data = String.new(bytes, "cp1252").strip
    #                 end
    #             end

    #             qualityByte = binary.read_bytes(UInt8).to_i32
    #             errorByte = binary.read_bytes(UInt8)
    #             next unless data

    #             quality = Vkt7DataQuality.new(qualityByte)                                
    #             yield Vkt7ElementData.new(element.itemType, size, data, quality, errorByte)                
    #         end
    #     end
    # end
end
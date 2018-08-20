module Vkt7Driver
  # Select items in Vkt7
  class SelectItemsExecuter < BaseExecuter(Bool)
    # Parameters to get data
    getter requests = Set(ElementRequest).new

    @dataType : Vkt7DataType

    def initialize(deviceInfo : MeterDeviceInfo, protocol : ModbusRtuProtocol, @dataType : Vkt7DataType)
      super(deviceInfo, protocol)
    end

    # Add item to read info
    def addItemType(parameter : ElementRequest) : Void
      @requests.add(parameter)
    end

    # Execute and iterate values in block
    def execute(&block : Bool -> Void) : Void
      execute
      yield true
    end

    # Execute without block
    def execute : Void
      network = @deviceInfo.networkNumber.to_u8

      # Select data type
      response = @protocol.sendRequestWithResponse(PresetMultipleRegistersRequest.new(
        network, Vkt7StartAddress::WriteDataType, 0_u16, Bytes[0x02, @dataType, 0x00]))

      binary = IO::Memory.new
      binary.write_bytes((@requests.size * 6).to_u8)
      @requests.each do |request|
        binary.write_bytes((0x40000000 + request.itemType.to_i32).to_i32)
        binary.write_bytes(request.size)
      end

      response = @protocol.sendRequestWithResponse(PresetMultipleRegistersRequest.new(
        network, Vkt7StartAddress::WriteElementTypes, 0_u16, binary.to_slice))
    end
  end
end

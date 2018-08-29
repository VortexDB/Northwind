module VktDriver
  struct ActiveElementInfo
    # Element type
    getter elementType : Vkt7DataElementType

    # Element size
    getter size : UInt16

    def initialize(@elementType : Vkt7DataElementType, @size : UInt16)
    end
  end

  # Read active element info
  class ActiveElementReader < BaseExecuter(ActiveElementInfo)
    # Execute and iterate values in block
    def execute(&block : ActiveElementInfo -> Void) : Void
      network = @deviceInfo.networkNumber.to_u8

      # Read values
      response = @protocol.sendRequestWithResponse(ReadHoldingRegistersRequest.new(network, Vkt7StartAddress::ReadActiveElement, 0_u16))
      binary = IO::Memory.new(response.data, false)
      binary.seek(1) # Ignore data length

      begin
        loop do
          elementId = binary.read_bytes(UInt32).to_i32
          elementId = elementId - 0x40000000
          elementSize = binary.read_bytes(UInt16)
          elementType = Vkt7DataElementType.new(elementId)
          yield ActiveElementInfo.new(elementType, elementSize)
        end
      rescue ex : IO::EOFError
      end
    end
  end
end

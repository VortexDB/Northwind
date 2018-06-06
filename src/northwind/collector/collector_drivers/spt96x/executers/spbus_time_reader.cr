# Read time
class SpbusTimeReader
  # Protocol for send/receive data
  @protocol : SpbusProtocol

  # Complete block
  @completeBlock : Proc(Time, Void)

  def initialize(@protocol, &block : Time -> _)
    @completeBlock = block
    execute
  end

  # Send request and read
  def execute : Void
    binary = IO::Memory.new
    binary.write_bytes(SpbusSpecialBytes::HT_BYTE)
    binary << "0"               # Channel
    binary.write_bytes(SpbusSpecialBytes::HT_BYTE)
    binary << "60"              # Parameter
    binary.write_bytes(SpbusSpecialBytes::FF_BYTE)

    binary.write_bytes(SpbusSpecialBytes::HT_BYTE)    
    binary << "0"               # Channel
    binary.write_bytes(SpbusSpecialBytes::HT_BYTE)
    binary << "61"              # Parameter
    binary.write_bytes(SpbusSpecialBytes::FF_BYTE)

    request = SpbusProtocolRequest.new(
      0x1D_u8,
      binary.to_slice
    )

    response = @protocol.sendRequestWithResponse(request)

    @completeBlock.call(Time.now)
  end
end

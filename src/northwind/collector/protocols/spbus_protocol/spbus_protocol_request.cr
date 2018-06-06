# Protocol data for creating requests
class SpbusProtocolRequest < ProtocolRequest
  # Device using address
  getter usingAddress : Bool

  # Address of device
  getter destAddress : UInt8

  # Self address
  getter serverAddress : UInt8

  # Function of request
  getter function : UInt8

  # Function data
  getter data : Bytes

  def initialize(
    @function,
    @data,
    @usingAddress = false,
    @destAddress = 0_u8,
    @serverAddress = 0_u8
  )
  end
end

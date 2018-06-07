module Spt96xDriver
  # Info for passing to protocol driver
  class DeviceInfo
    # Device using address
    getter usingAddress : Bool

    # Address of device
    getter destAddress : UInt8

    # Self address
    getter serverAddress : UInt8

    def initialize(
      @usingAddress = false,
      @destAddress = 0_u8,
      @serverAddress = 0_u8
    )
    end
  end
end

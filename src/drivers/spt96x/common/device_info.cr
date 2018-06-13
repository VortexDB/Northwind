module Spt96xDriver
  # Device type
  enum DeviceType
    Meter,
    Pipe,
    Group
  end

  # Info for passing to protocol driver
  class DeviceInfo
    # Device type
    getter deviceType : DeviceType

    # Pipe number
    getter pipeNumber : Int32

    # Group number
    getter groupNumber : Int32

    # Device using address
    getter usingAddress : Bool

    # Address of device
    getter destAddress : UInt8

    # Self address
    getter serverAddress : UInt8

    def initialize(
      @deviceType = DeviceType::Meter,
      @pipeNumber = 0,
      @groupNumber = 0,
      @usingAddress = false,
      @destAddress = 0_u8,
      @serverAddress = 0_u8
    )
    end
  end
end

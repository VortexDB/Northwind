module VktDriver
  # Data quality
  enum Vkt7DataQuality
    OPC_QUALITY_GOOD           = 0xC0,
    OPC_QUALITY_BAD            = 0x00,
    OPC_QUALITY_CONFIG_ERROR   = 0x04,
    OPC_QUALITY_DEVICE_FAILURE = 0x0C,
    OPC_QUALITY_UNCERTAIN      = 0x40,
    OPC_QUALITY_SENSOR_CAL     = 0x50
  end

  # Data of element
  class Vkt7ElementData
    # Element type
    getter element : Vkt7ElementType

    # Size of element data
    getter size : UInt16

    # Data of element
    getter data : (Float64 | String)

    # Quality
    getter quality : Vkt7DataQuality

    # Error code
    getter errorCode : UInt8

    def initialize(@element, @size, @data, @quality, @errorCode)
    end
  end
end

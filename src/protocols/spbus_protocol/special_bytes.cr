# Special bytes for spbus protocol
class SpbusSpecialBytes
  # DLE byte
  DLE_BYTE = 0x10_u8
  
  # Start byte
  SOH_BYTE = 0x01_u8

  # Function start byte
  ISI_BYTE = 0x1F_u8

  # Start transmit data
  STX_BYTE = 0x02_u8

  # End transmit data
  ETX_BYTE = 0x03_u8

  # Horizontal tab
  HT_BYTE = 0x09_u8

  # Delimeter
  FF_BYTE = 0x0C_u8
end

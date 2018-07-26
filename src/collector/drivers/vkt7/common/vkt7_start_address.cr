module Vkt7Driver
    # Modbus start address for Vkt7
    class Vkt7StartAddress
        # Address for start session
        StartSessionAddress = 0x3FFF_u16
        # Read time address
        TimeAddress = 0x3FFB_u16
        # Read data address
        ReadDataAddress = 0x3FFE_u16
        # Write data type
        WriteDataType = 0x3FFD_u16
        # Write element types
        WriteElementTypes = 0x3FFF_u16
    end
end
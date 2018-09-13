module VktDriver
    # Modbus start address for Vkt
    class VktStartAddress
        # Address for start session
        StartSessionAddress = 0x3FFF_u16
        # Read time address
        TimeAddress = 0x3FFB_u16
        # Read data address
        ReadDataAddress = 0x3FFE_u16
        # Read active element data
        ReadActiveElement = 0x3FFC_u16
        # Write data type
        WriteDataType = 0x3FFD_u16
        # Write element types
        WriteElementTypes = 0x3FFF_u16        
    end
end
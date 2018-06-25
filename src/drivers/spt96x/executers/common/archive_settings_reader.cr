module Spt96xDriver
  # Archive settings reader
  class ArchiveSettingsReader
    # Function of reading parameter
    FUNCTION = 0x19_u8

    # Protocol to send data
    @protocol : SpbusProtocol

    def initialize(@protocol)
      @parameters = Set(RequestParameter).new
    end

    # Execute and return response
    def execute : ArchiveSettingsResponse
        
    end
  end
end

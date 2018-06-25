module Spt96xDriver
  # Reads archive
  class ArchiveReader
    # Data reader
    @reader : ArchiveParameterReader

    def initialize(@startDate, @endDate)
      @reader = ArchiveParameterReader.new(startDate, endDate)
    end

    # Add request parameter
    def addParameter(parameter : RequestParameter) : Void
      @reader.add(parameter)
    end

    # Send request and read
    def execute(protocol : SpbusProtocol, &block : ValueData -> _) : Void
      # Read settings

      settingsReader = ProfileSettingsReader.new(profile)
      settingsResp = settingsReader.execute

      # Read archive
      @reader.execute do |response|
        
      end
    end
  end
end

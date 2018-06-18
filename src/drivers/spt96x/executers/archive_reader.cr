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

    #   settingsReader = ParameterReader.new(protocol)
    #   @reader.requests.each do |param|
    #     settingsReader.addParameter(param)
    #   end

    #   settingsReader.execute do |value|

    #   end

      # Read archive
      values = @reader.execute
      values.each do |value|
        
      end
    end
  end
end

module Spt96xDriver
  # Read archive parameter
  class ArchiveParameterReader
    # Function of reading parameter
    FUNCTION = 0x0E_u8

    # Start date of request
    getter startDate : Time

    # End date of request
    getter endDate : Time

    # Requests
    getter requests : Array(RequestParameter)

    def initialize(@start, @end)
    end

    # Add request parameter
    def addParameter(parameter : RequestParameter) : Void
      @requests.add(parameter)
    end

    # Add request parameter
    def addParameters(parameters : Array(RequestParameter)) : Void
      @requests.add_all(parameters)
    end

    # Execute reading
    def execute(&block : ReadDataResponse -> Void)
      @parameters.each do |x|
        binary = IO::Memory.new
        request = SpbusProtocolRequest.new(
          FUNCTION,
          binary.to_slice
        )

        response = @protocol.sendRequestWithResponse(request)
        yield data
      end      
    end
  end
end

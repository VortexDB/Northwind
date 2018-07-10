module Spt96xDriver
  # Read some parameters
  class ParameterReader
    # Function of reading parameter
    FUNCTION = 0x1D_u8

    # Protocol to send data
    @protocol : Protocol

    # Parameters to read
    @parameters : Set(RequestParameter)

    def initialize(@protocol)
      @parameters = Set(RequestParameter).new
    end

    # Add parameter to read
    def addParameter(parameter : RequestParameter)
      @parameters.add(parameter)
    end

    # Execute reading
    def execute : Array(ReadParameterResponse)
      binary = IO::Memory.new
      @parameters.each do |x|
        BinaryHelper.addRequestParameter(binary, x)
      end      

      request = SpbusRequest.new(
        FUNCTION,
        binary.to_slice
      )

      response = @protocol.sendRequestWithResponse(request).as(SpbusResponse)
      parser = ResponseParser.new
      return parser.parseReadParametersToArray(response.data)
    end
  end
end

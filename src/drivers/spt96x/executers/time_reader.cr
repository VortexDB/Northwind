module Spt96xDriver
  # Read time
  class TimeReader
    # Protocol for send/receive data
    @protocol : SpbusProtocol

    # Complete block
    @completeBlock : Proc(Time, Void)

    # Send request and read
    private def execute : Void
      binary = IO::Memory.new      
      BinaryHelper.addRequestParameter(binary, RequestBuilder.date)
      BinaryHelper.addRequestParameter(binary, RequestBuilder.time)

      request = SpbusProtocolRequest.new(
        0x1D_u8,
        binary.to_slice
      )

      response = @protocol.sendRequestWithResponse(request)
      parser = ResponseParser.new
      datePar, timePar = parser.parseReadParametersToArray(response.data)
      date = parser.parseDateValue(datePar.data.value, datePar.data.measure.not_nil!) + 
             parser.parseTimeValue(timePar.data.value, timePar.data.measure.not_nil!)

      @completeBlock.call(date)
    end

    def initialize(@protocol, &block : Time -> _)
      @completeBlock = block
      execute
    end
  end
end

module Spt96xDriver
  # Read time
  class TimeReader
    # Send request and read
    private def execute(protocol, &block : Time -> _) : Void
      reader = ParameterReader.new(protocol)
      reader.addParameter(RequestBuilder.date)
      reader.addParameter(RequestBuilder.time)

      datePar, timePar = reader.execute
      date = ResponseParser.parseDateValue(datePar.data.value, datePar.data.measure.not_nil!) +
             ResponseParser.parseTimeValue(timePar.data.value, timePar.data.measure.not_nil!)

      block.call(date)
    end

    def initialize(protocol, &block : Time -> _)
      execute(protocol, &block)
    end
  end
end

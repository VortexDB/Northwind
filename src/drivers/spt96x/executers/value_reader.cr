module Spt96xDriver
  # Current value data info
  struct ValueData
    # Request info
    getter request : RequestParameter

    # Value
    getter value : Float64

    def initialize(@request, @value)      
    end
  end

  # Read current value from device/pipe/group
  class ValueReader
    # Requests
    @requests : Set(RequestParameter)

    def initialize
      @requests = Set(RequestParameter).new
    end

    # Add request parameter
    def addParameter(parameter : RequestParameter) : Void
      @requests.add(parameter)
    end

    # Send request and read
    def execute(protocol : SpbusProtocol, &block : ValueData -> _) : Void
      
    end
  end
end

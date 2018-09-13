module Collector
  # Data for sending to protocol
  abstract class ProtocolRequest
  end

  # Data from protocol
  abstract class ProtocolResponse
  end

  # Abstract protocol
  abstract class TransportProtocol
    # Channel for sending data
    property! channel : TransportChannel?    

    # Calc hash
    def hash
      self.class.name.hash
    end

    # Equals
    def ==(other : Protocol)
      hash == other.hash
    end
  end

  # Abstract protocol
  abstract class ResponseRequestProtocol < TransportProtocol
    # Send applied request
    # And yields response
    abstract def sendRequestWithResponse(request : ProtocolRequest) : ProtocolResponse
  end
end

module Collector
  # Data for sending to protocol
  abstract class ProtocolRequest
  end

  # Data from protocol
  abstract class ProtocolResponse
  end

  # Protocol channel mixin
  module ProtocolChannel(T)
    # Transport channel
    @channel : T?

    def channel! : T
      @channel.not_nil!
    end

    # Channel    
    def channel=(channel : T)
      @channel = channel
    end
  end

  # Simple response request protocol
  module ResponseRequestProtocol(TRequest, TResponse)
    # Send applied request
    # And yields response
    abstract def sendRequestWithResponse(request : TRequest) : TResponse
  end

  # Abstract protocol
  abstract class Protocol
    def initialize
    end    

    # Calc hash
    def hash
      self.class.name.hash
    end

    # Equals
    def ==(other : Protocol)
      hash == other.hash
    end
  end
end

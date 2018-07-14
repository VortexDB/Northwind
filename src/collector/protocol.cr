module Collector
  # Data for sending to protocol
  abstract class ProtocolRequest
  end

  # Data from protocol
  abstract class ProtocolResponse
  end

  # Protocol channel mixin
  module ProtocolChannel(T)
    # macro included
    # end

    # Transport channel
    @channel : T?

    def channel! : T
      @channel.not_nil!
    end

    # Channel    
    def channel=(channel : T)
      @channel = channel
    end

    # Channel sure
    # def channel!
    #   @channel.not_nil!
    # end
  end

  # Abstract protocol
  abstract class Protocol 
    # def channel=(chan : TransportChannel)
    #   @channel = chan
    #   # channel!.onChannelData do |data, count|
    #   #     onChannelData(data, count)
    #   # end
    # end

    def initialize
    end

    # Send applied request
    # And yields response
    abstract def sendRequestWithResponse(request : ProtocolRequest) : ProtocolResponse

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

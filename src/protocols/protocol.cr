# Data for sending to protocol
class ProtocolRequest
end

# Data from protocol
class ProtocolResponse   
end

# Abstract protocol
abstract class Protocol
    # Channel to send data
    @channel : TransportChannel?

    def channel=(chan : TransportChannel)
        @channel = chan
        # channel!.onChannelData do |data, count|
        #     onChannelData(data, count)
        # end      
    end

    def channel!
        @channel.not_nil!
    end

    def initialize
    end

    # Send applied request
    # And yields response
    abstract def sendRequestWithResponse(protocolData : ProtocolRequest) : ProtocolResponse
end
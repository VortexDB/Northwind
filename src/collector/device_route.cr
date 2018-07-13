module Collector
  # Route for connection
  abstract class DeviceRoute
    # Return channel type
    abstract def channelType : TransportChannel.class
  end

  # Route for TCP client
  class TcpClientRoute < DeviceRoute
    # Return channel type
    def channelType : TransportChannel.class
      TransportChannels::TcpClientChannel
    end

    # Server host
    getter hostOrIp : String

    # Port for connection
    getter port : Int32

    def initialize(@hostOrIp, @port)
    end

    def hash
      hostOrIp.hash ^ port
    end

    def ==(obj)
      hash == obj.hash
    end
  end
end

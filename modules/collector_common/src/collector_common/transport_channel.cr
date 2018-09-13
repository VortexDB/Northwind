module Collector
  # Base transport channel
  abstract class TransportChannel
    macro registerRoute(routeType)      
      TransportChannelFactory.possibleChannels[{{ routeType }}] = {{ @type }}
    end

    # Route to device
    getter route : DeviceRoute

    def initialize(@route : DeviceRoute)
    end

    # Open channel
    abstract def open(timeout : Int32) : Void

    # Close channel
    abstract def close : Void
  end

  # Client channel that connects to some server
  abstract class ClientTransportChannel < TransportChannel
  end

  # Client channel that connects to some server
  abstract class ServerTransportChannel < TransportChannel
  end

  # Base binary transport channel mixin
  # Common interface for most devices
  module BinaryTransportChannel
    # Send data to channel
    abstract def write(data : Bytes) : Void

    # Read data from channel
    abstract def read : {Bytes, Int32}
  end

  # Channel to write, read text
  module TextTransportChannel
    # Send text to channel
    abstract def write(data : String) : Void

    # Read data from channel
    abstract def readLine : String
  end

  # Base custom channel for specific devices that can be client and server or something else
  abstract class CustomTransportChannel < TransportChannel
  end

  # Channel factory
  class TransportChannelFactory
    # Possible channels for creating
    class_property possibleChannels = Hash(DeviceRoute.class, TransportChannel.class).new

    # Create channel by route
    def self.get(route : DeviceRoute)
      classType = TransportChannelFactory.possibleChannels[route.class]?
      if classType.nil?
        raise NorthwindException.new("No possible channel to handle #{route.class.name} route")
      end

      return classType.new(route)
    end
  end
end

require "./device_route"
require "../utils/northwind_exception"

module Collector
  # Base transport channel
  abstract class TransportChannel
    macro register(*routeTypes)
      {% for r in routeTypes %}
        Collector::TransportChannel.possibleChannels["Collector::" + {{ r.stringify }}] =
              Proc(Collector::DeviceRoute, Collector::TransportChannel).new { |x| {{ @type.id }}.new(x) }
      {% end %}
    end

    # Create channel by route
    def self.create(route : DeviceRoute)
      routeClassName = route.class.to_s      
      constructor = TransportChannel.possibleChannels[routeClassName]?
      if constructor.nil?
        raise NorthwindException.new("No possible channel to handle route")
      end

      return constructor.call(route)
    end

    # Possible channels for creating
    class_property possibleChannels = Hash(String, Proc(DeviceRoute, TransportChannel)).new

    # Route to device
    getter route : DeviceRoute

    def initialize(@route : DeviceRoute)
    end

    # Open channel
    abstract def open : Void

    # Close channel
    abstract def close : Void
  end

  # Base binary transport channel
  # Common channel for most devices
  abstract class BinaryTransportChannel < TransportChannel
    # Send data to channel
    abstract def write(data : Bytes) : Void

    # Read data from channel
    abstract def read : {Bytes, Int32}
  end

  # Base custom channel for specific devices
  abstract class CustomTransportChannel < TransportChannel
  end
end

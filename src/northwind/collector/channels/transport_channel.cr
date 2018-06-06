# Base transport channel
abstract class TransportChannel
  macro register(*routeTypes)
    {% for r in routeTypes %}
        TransportChannel.possibleChannels[{{ r.stringify }}] =
            Proc(DeviceRoute, TransportChannel).new { |x| {{ @type.id }}.new(x) }
    {% end %}
  end

  # # Block to notify channel data
  # @onChannelDataBlock : Proc(Bytes, Int32, Void)?

  # Possible channels for creating
  class_property possibleChannels = Hash(String, Proc(DeviceRoute, TransportChannel)).new

  # Route to device
  getter route : DeviceRoute

  # Create channel by route
  def self.create(route : DeviceRoute)
    routeClassName = route.class.to_s
    constructor = possibleChannels[routeClassName]?
    if constructor.nil?
      raise NorthwindException.new("No possible channel to handle route")
    end

    return constructor.call(route)
  end

  def initialize(@route : DeviceRoute)
  end

  # Open channel
  abstract def open : Void

  # Send data to channel
  abstract def write(data : Bytes) : Void

  # Read data from channel
  abstract def read : { Bytes, Int32 }

  # Close channel
  abstract def close : Void

  # # Notify data from channel
  # def onChannelData(&block : Bytes, Int32 -> _) : Void
  #   @onChannelDataBlock = block
  # end

  # # Notify channel data
  # def notifyChannelData(data : Bytes, count : Int32) : Void
  #   @onChannelDataBlock.try &.call(data, count)
  # end
end

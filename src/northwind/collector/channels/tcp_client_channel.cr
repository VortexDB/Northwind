require "./*"
require "socket"

# Channel for tcp
class TcpClientChannel < TransportChannel
  register(TcpClientRoute)

  # Read buffer size
  READ_BUFFER_SIZE = 4096

  # Socket to send/read
  @socket = TCPSocket.new

  # Packets queue
  @packets = Array(Bytes).new

  # Channel at work
  @isWorking = false

  # Write in progress
  @isWriting = false

  def tcpRoute
    @route.as(TcpClientRoute)
  end

  # Open channel
  def open : Void
    @socket.connect(tcpRoute.hostOrIp, tcpRoute.port)
    @isWorking = true
    # startRead
  end

  # # Start write to socket
  # def startWrite
  #   spawn do
  #     begin
  #       @isWriting = true
  #       while @isWorking
  #         break if @packets.empty?
  #         data = @packets.shift
  #         @socket.write(data)
  #       end
  #     rescue e : Exception
  #       if @isWorking
  #         # TODO: notify about error
  #         p "SEND ERROR"
  #         p e
  #       end
  #     end
  #     @isWriting = false
  #   end
  # end

  # # Start work
  # def startRead
  #   spawn do
  #     begin
  #       buffer = Bytes.new(READ_BUFFER_SIZE)
  #       while @isWorking
  #         count = @socket.read(buffer)
  #         notifyChannelData(buffer, count)
  #       end
  #     rescue e : Exception
  #       if @isWorking
  #         # TODO: notify about error
  #         p "READ ERROR"
  #         p e
  #       end
  #     end
  #   end
  # end

  # Send data to channel
  def write(data : Bytes) : Void
    @socket.write(data)
  end

  # Read data from channel
  def read : {Bytes, Int32}
    buffer = Bytes.new(READ_BUFFER_SIZE)
    count = @socket.read(buffer)
    return {buffer, count}
  end

  # Close channel
  def close : Void
    @isWorking = false
    @socket.close
  end
end

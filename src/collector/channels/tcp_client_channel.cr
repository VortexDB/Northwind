require "socket"

module TransportChannels
  include Collector

  # Channel for tcp
  class TcpClientChannel < ClientTransportChannel
    include BinaryTransportChannel    

    register(TcpClientRoute)

    # Connect timeout in secods
    DEFAULT_CONNECT_TIMEOUT = 3

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
    def open(timeout : Int32 = DEFAULT_CONNECT_TIMEOUT) : Void
      @socket.connect(tcpRoute.hostOrIp, tcpRoute.port, timeout)
      @isWorking = true
    end

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
end

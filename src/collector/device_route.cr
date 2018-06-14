module Collector
  # Route for connection
  class DeviceRoute
  end

  # Route for TCP client
  class TcpClientRoute < DeviceRoute
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

module SpbusProtocol
  # Protocol response
  class SpbusResponse < ProtocolResponse
    # Function
    getter function : UInt8

    # Data
    getter data : Bytes

    def initialize(@function, @data)
    end
  end
end

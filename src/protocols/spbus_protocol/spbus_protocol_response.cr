module SpbusProtocol
  # Protocol response
  class SpbusProtocolResponse < ProtocolResponse
    # Function
    getter function : UInt8

    # Data
    getter data : Bytes

    def initialize(@function, @data)
    end
  end
end

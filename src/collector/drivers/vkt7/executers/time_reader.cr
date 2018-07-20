module Vkt7Driver
  # Read time
  class TimeReader < DriverTimeReader(MeterDeviceInfo, ModbusRtuProtocol)    
    TIME_ADDRESS = 0x3FFB_u16    

    # Send request and read
    def execute(&block : Time -> _) : Void
      network = @deviceInfo.networkNumber.to_u8
      response = @protocol.sendRequestWithResponse(ReadHoldingRegistersRequest.new(network, TIME_ADDRESS, 0_u16))
      if network != response.network
        raise NorthwindException.new("Request network address not equals response network address")
      end

      begin
        buffer = IO::Memory.new(response.data)
        buffer.seek(1)  # Skip length
        day = buffer.read_byte.not_nil!
        month = buffer.read_byte.not_nil!
        yearByte = buffer.read_byte.not_nil!
        hour = buffer.read_byte.not_nil!
        minute = buffer.read_byte.not_nil!
        second = buffer.read_byte.not_nil!    
      
        year = 2000 + yearByte
        yield Time.new(year, month.to_i32, day.to_i32, hour.to_i32, minute.to_i32, second.to_i32)
      rescue e : Exception
        pp e.inspect_with_backtrace
        raise NorthwindException.new("Wrong answer")
      end
    end
  end
end
module Vkt7Driver
  # Start session and read version of device
  class StartSessionExecuter < BaseExecuter(Bool)
    # Address for start session
    START_SESSION_ADDRESS = 0x3FFF_u16

    # Execute and iterate values in block
    def execute(&block : Bool -> _)
        network = @deviceInfo.networkNumber.to_u8
        data = Slice[0xCC_u8, 0x80_u8, 0x00_u8, 0x00_u8, 0x00_u8]        
        response = @protocol.sendRequestWithResponse(
            PresetMultipleRegistersRequest.new(network, START_SESSION_ADDRESS, 0_u16, data))
        yield true
    end
  end
end

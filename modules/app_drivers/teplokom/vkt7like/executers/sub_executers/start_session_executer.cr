module VktDriver
  # Start session and return version of device
  class StartSessionExecuter < BaseExecuter(UInt8)
    # Position of version byte
    VERSION_POS = 62

    # Execute and iterate values in block
    def execute(&block : UInt8 -> _)
      network = vktModel.networkNumber
      data = Bytes[0xCC, 0x80, 0x00, 0x00, 0x00]
      # Start session
      modbusProtocol.sendRequestWithResponse(
        PresetMultipleRegistersRequest.new(network, VktStartAddress::StartSessionAddress, 0_u16, data))

      # Read VKT version
      response = modbusProtocol.sendRequestWithResponse(ReadHoldingRegistersRequest.new(network, VktStartAddress::ReadDataAddress, 0_u16))
      yield response.data[VERSION_POS]
    end
  end
end

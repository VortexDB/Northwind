require "../../protocols/modbus_protocol/**"

module Vkt7Driver
  include Collector
  include ModbusProtocol

  # Driver for VKT-7 thermal meter
  class Driver < CollectorDriver
    # Protocol
    @protocol = ModbusProtocol.new

    # Set transport channel
    def channel=(value : TransportChannel)
      @protocol.channel = value
    end

    # Execute device task
    def appendTask(deviceTasks : CollectorDeviceTasks) : Void
    end
  end
end

require "../../../collector_driver"

module VktDriver
    # Executer context
    class VktExecuterContext < ExecutionContext(DeviceInfo, ModbusRtuProtocol)
        def initialize(deviceInfo, protocol)
            super(deviceInfo, protocol)
        end
    end
end
module Vkt7Driver
    # Start session and read version of device
    class StartSessionExecuter < CollectorDriverExecuter(MeterDeviceInfo, ModbusRtuProtocol)
        # Execute and return device version
        def execute() : String
            
        end
    end
end
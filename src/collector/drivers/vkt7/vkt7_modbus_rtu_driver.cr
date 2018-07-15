module Vkt7Driver  
  include Collector  
  include ModbusProtocol::ModbusRtu

  # Driver for VKT-7 thermal meter
  class Vkt7ModbusRtuDriver < CollectorDriver
    register("Vkt7", ModbusRtuProtocol)

    # Execute device task
    def appendTask(deviceTasks : CollectorDeviceTasks) : Void
      p "VKT appendTask"
    end
  end
end

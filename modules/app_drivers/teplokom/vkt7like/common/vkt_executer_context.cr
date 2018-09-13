require "collector_common"

module VktDriver
  # Executer context for Vkt driver
  class VktExecuterContext < ExecutionContext
    # Vkt meter model
    getter meterModel : VktModel

    def initialize(deviceInfo, protocol, @meterModel)
      super(deviceInfo, protocol)
    end
  end
end

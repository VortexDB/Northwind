module Collector
  # Abstract execution context for transfering it between driver and executers
  class ExecutionContext
    # Device information
    getter deviceInfo : DeviceInfo

    # Protocol information
    getter protocol : TransportProtocol

    def initialize(@deviceInfo, @protocol)
    end
  end
end

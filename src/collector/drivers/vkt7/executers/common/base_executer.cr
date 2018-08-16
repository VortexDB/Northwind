module Vkt7Driver  
  # Base executer
  abstract class BaseExecuter(TResponseType) < CollectorDriverExecuter(MeterDeviceInfo, ModbusRtuProtocol, TResponseType)
  end

  # Common executer with start session
  abstract class CommonExecuter(TResponseType) < BaseExecuter(TResponseType)
    VERSION_ZERO = 0
    VERSION_ONE = 1

    # Version of VKT-7
    @serverVersion : UInt8 = 0

    # To implement
    abstract def postExecute(&block : TResponseType -> Void) : Void

    # Start session and execute other
    def execute(&block : TResponseType -> Void) : Void
      StartSessionExecuter.new(@deviceInfo, @protocol) do |version|
        @serverVersion = version
        postExecute(&block)
      end
    end
  end
end

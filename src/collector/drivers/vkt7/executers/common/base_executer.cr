module Vkt7Driver
  # Base executer
  abstract class BaseExecuter(TResponseType) < CollectorDriverExecuter(MeterDeviceInfo, ModbusRtuProtocol, TResponseType)    
    # Execute and return response
    abstract def execute(&block : TResponseType -> Void) : Void
  end

  # Common executer with start session
  abstract class CommonExecuter(TResponseType) < BaseExecuter(TResponseType)
    # Version of VKT-7
    @serverVersion : UInt8 = 0    

    # To implement
    abstract def postExecute(&block : TResponseType -> _) : Void

    # Start session and execute other
    def execute(&block : TResponseType -> Void) : Void
      StartSessionExecuter.new(@deviceInfo, @protocol) do |version|
        @serverVersion = version
        postExecute(&block)
      end
    end
  end
end

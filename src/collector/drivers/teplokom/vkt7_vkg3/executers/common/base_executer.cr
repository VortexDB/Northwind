module VktDriver
  # Base executer
  abstract class BaseExecuter(TResponseType) < CollectorDriverExecuter(MeterDeviceInfo, ModbusRtuProtocol, TResponseType)
  end

  # Common executer with start session
  abstract class CommonExecuter(TResponseType) < BaseExecuter(TResponseType)
    VERSION_ZERO = 0
    VERSION_ONE  = 1

    # Version of VKT-7
    @serverVersion : UInt8 = 0

    # Vkt meter model
    getter meterModel : VktModel

    def initialize(deviceInfo : MeterDeviceInfo, protocol : ModbusRtuProtocol, @meterModel : VktModel)      
      super(deviceInfo, protocol)
    end

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

  # Common executer to read values: current or profile
  abstract class CommonValueExecuter(TResponseType) < CommonExecuter(TResponseType)
    # Requests
    @parameters = Set(MeasureParameter).new

    # Add parameter for reading
    def addParameter(parameter : MeasureParameter) : Void
      @parameters.add(parameter)
    end    
  end
end

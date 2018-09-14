module VktDriver  
  # Base executer
  abstract class BaseExecuter(TResponse) < CollectorDriverExecuter(TResponse)
    # Context for vkt executer
    getter vktExecuterContext : VktExecuterContext

    # Return modbus rtu protocol
    def modbusProtocol : ModbusProtocol::ModbusProtocol
      return vktExecuterContext.modbusProtocol
    end

    # Return model for vkt7 device
    def vktModel : VktModel
      return vktExecuterContext.meterModel
    end

    def initialize(@vktExecuterContext)
      super(@vktExecuterContext)
    end

    def initialize(@vktExecuterContext, &block : TResponse -> Void)
      super(@vktExecuterContext, &block)
    end
  end

  # Common executer with start session
  abstract class CommonExecuter(TResponse) < BaseExecuter(TResponse)
    # VKT firmware version 0
    VERSION_ZERO = 0
    # VKT firmware version 1
    VERSION_ONE  = 1

    # Version of VKT-7
    @serverVersion : UInt8 = 0    

    # To implement
    abstract def postExecute(&block : TResponse -> Void) : Void

    # Start session and execute other
    def execute(&block : TResponse -> Void) : Void
      StartSessionExecuter.new(vktExecuterContext) do |version|
        @serverVersion = version
        postExecute(&block)
      end
    end
  end

  # Common executer to read values: current or profile
  abstract class CommonValueExecuter(TResponse) < CommonExecuter(TResponse)
    # Requests
    @parameters = Set(MeasureParameter).new

    # Add parameter for reading
    def addParameter(parameter : MeasureParameter) : Void
      @parameters.add(parameter)
    end
  end
end

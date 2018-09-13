module VktDriver
  include ModbusProtocol::ModbusRtu

  # Base executer
  abstract class BaseExecuter(TResponse) < CollectorDriverExecuter(TResponse)
    # Return modbus rtu protocol
    def modbusProtocol : ModbusRtuProtocol
      return executionContext.protocol.as(ModbusRtuProtocol)
    end

    # Return model for vkt7 device
    def vktModel : VktModel
      return executionContext.as(VktExecuterContext).meterModel
    end

    def initialize(executionContext : VktExecuterContext)
      super(executionContext)
    end

    def initialize(@executionContext : ExecutionContext, &block : TResponse -> Void)
      super(executionContext, &block)
    end
  end

  # Common executer with start session
  abstract class CommonExecuter(TResponse) < BaseExecuter(TResponse)
    VERSION_ZERO = 0
    VERSION_ONE  = 1

    # Version of VKT-7
    @serverVersion : UInt8 = 0

    def initialize(executionContext : VktExecuterContext)
      super(executionContext)
    end

    def initialize(@executionContext : ExecutionContext, &block : TResponse -> Void)
      super(executionContext, &block)
    end

    # To implement
    abstract def postExecute(&block : TResponse -> Void) : Void

    # Start session and execute other
    def execute(&block : TResponse -> Void) : Void
      StartSessionExecuter.new(executionContext) do |version|
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

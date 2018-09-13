module VktDriver
  # Common executer with start session
  abstract class CommonExecuter(TResponse) < CollectorDriverExecuter(TResponse)
    VERSION_ZERO = 0
    VERSION_ONE  = 1

    # Version of VKT-7
    @serverVersion : UInt8 = 0

    # Vkt meter model
    getter meterModel : VktModel

    def initialize(executionContext : ExecutionContext, @meterModel : VktModel)
      super(executionContext)
    end

    # To implement
    abstract def postExecute(&block : TResponse -> Void) : Void

    # Start session and execute other
    def execute(&block : TResponse -> Void) : Void
      StartSessionExecuter.new(@deviceInfo, @protocol) do |version|
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

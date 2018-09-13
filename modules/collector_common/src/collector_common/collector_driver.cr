module Collector
  # Device type
  enum DeviceType
    # Self meter
    Meter,
    # Pipe of device
    Pipe,
    # Pipe group of device
    Group
  end

  # Base device info
  abstract class DeviceInfo
  end

  # Base device info
  class MeterDeviceInfo < DeviceInfo
    # Device network number
    getter networkNumber : Int32 = 1
  end

  # Info for passing to protocol driver
  class PipeDeviceInfo < MeterDeviceInfo
    # Pipe number
    getter pipeNumber : Int32

    # Group number
    getter groupNumber : Int32

    def initialize(
      @pipeNumber = 0,
      @groupNumber = 0
    )
      super()
    end
  end

  # Abstract execution context for transfering it between driver and executers
  class ExecutionContext
    # Device information
    getter deviceInfo : DeviceInfo

    # Protocol information
    getter protocol : TransportProtocol

    def initialize(@deviceInfo, @protocol)
    end
  end  

  # Base event
  abstract class CollectorDriverEvent
  end

  # Data value from driver
  alias DataValue = Float64 | Time | String

  # Type of TaskDataEvent
  alias DataTaskValue = DataValue | TimedDataValue
  
  # Value with time
  struct TimedDataValue
    # Date time for value
    getter dateTime : Time

    # Value
    getter value : DataValue

    def initialize(@value, @dateTime)
    end
  end

  # Mixin for response value
  module TaskResponseValue(TValue)
    getter value : TValue
  end
  
  # Event on task
  abstract class DriverTaskResponseEvent < CollectorDriverEvent    
     getter taskId : Int32

     def initialize(@taskId)
     end
  end

  # Event on task with some values from device
  class TaskDataResponseEvent < DriverTaskResponseEvent
    include TaskResponseValue(DataTaskValue)    
    
    def initialize(taskId, @value)
      super(taskId)
    end
 end

  # Response event on time read
  class ReadTimeResponseEvent < DriverTaskResponseEvent    
    include TaskResponseValue(Time) 
    
    def initialize(taskId, @value)
      super(taskId)
    end
  end

  # Timeout
  class DriverTimeoutEvent < CollectorDriverEvent
  end

  # Driver executer context mixin
  module CollectorDriverExecuterContext(TExecuterContext)
    # Return executer context
    abstract def executerContext : TExecuterContext    
  end

  # Base collector drver
  abstract class CollectorDriver
    # Driver protocol
    getter protocol : TransportProtocol

    def initialize(@protocol)
    end    

    # Add tasks for device
    abstract def appendTask(deviceTasks : CollectorDeviceTasks) : Void

    # Listen block sure value
    def listenBlock!
      @listenBlock.not_nil!
    end

    # Listen for driver event
    def listen(&@listenBlock : CollectorDriverEvent -> Void) : Void
    end

    # Notify task event
    def notifyTaskEvent(event : CollectorDriverEvent) : Void
      listenBlock!.call(event)
    end

    # Calc hash
    def hash
      self.class.name.hash
    end

    # Equals
    def ==(other : CollectorDriver)
      hash == other.hash
    end
  end  

  # Base driver for meter
  # abstract class CollectorMeterDriver < CollectorDriver    
  #   # Collector device
  #   getter device : CollectorDevice?

  #   # Execute actions
  #   private def executeActions(tasks : Array(CollectorActionTask)) : Void
  #     tasks.each do |task|
  #       case task.actionInfo.action
  #       when StateAction::Read
  #         executeReadAction(task)
  #       when StateAction::Write
  #         executeWriteAction(task)
  #       else
  #         raise NorthwindException.new("Unknown action")
  #       end
  #     end
  #   end    

  #   # Execute before all task execution for device
  #   def executeBefore() : Void
  #   end

  #   # Execute after all task execution for device
  #   def executeAfter() : Void
  #   end

  #   # Process read action. Virtual
  #   def executeReadAction(action : CollectorActionTask) : Void
  #   end

  #   # Process write action. Virtual
  #   def executeWriteAction(action : CollectorActionTask) : Void
  #   end

  #   # Process read current values. Virtual
  #   def executeCurrentValues(tasks : Array(CollectorDataTask)) : Void
  #   end

  #   # Process read archive. Virtual
  #   def executeArchive(tasks : Array(CollectorDataTask)) : Void
  #   end

  #   # Execute device task
  #   def appendTask(deviceTasks : CollectorDeviceTasks) : Void
  #     @device = deviceTasks.device

  #     actions = deviceTasks.tasks.compact_map do |x|
  #       x if x.is_a?(CollectorActionTask)
  #     end

  #     current = Array(CollectorDataTask).new
  #     archive = Array(CollectorDataTask).new

  #     deviceTasks.tasks.each do |task|        
  #       case task
  #       when CollectorDataTask
  #         if task.parameter.discret.discretType == DiscretType::None
  #           current << task
  #         else
  #           archive << task
  #         end
  #       else
  #       end
  #     end
      
  #     executeBefore
  #     executeActions(actions) if !actions.empty?
  #     executeCurrentValues(current) if !current.empty?
  #     executeArchive(archive) if !current.empty?
  #     executeAfter
  #   end
  # end
end

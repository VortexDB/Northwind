require "../common/*"

# Base event
abstract class CollectorDriverEvent
end

# Add collector task event
class AddTaskEvent < CollectorDriverEvent
  # Device tasks
  getter deviceTasks : CollectorDeviceTasks

  def initialize(@deviceTasks)
  end
end

# Notifies about task complete
class TaskCompleteEvent < CollectorDriverEvent
  # Collector task id
  getter taskId : Int32

  def initialize(@taskId)
  end
end

# Notifies about task data
class TaskDataEvent < CollectorDriverEvent
  # Collector task id
  getter taskId : Int32

  def initialize(@taskId)
  end
end

# Timeout
class DriverTimeoutEvent < CollectorDriverEvent
end

# Driver with sporadic data
module CollectorDriverWithSporadic
end

# Collector driver that has own channel
module CollectorDriverWithOwnChannel
  # Open driver channel for route if there are no default channel
  abstract def openChannel(route : DeviceRoute) : Void

  # Close current channel for route
  abstract def closeChannel : Void
end

# Simple driver with external default channel
module CollectorDriverWithExternalChannel
  # Setter of channel
  abstract def channel=(value : TransportChannel)
end

# Base collector drver
abstract class CollectorDriver < AsyncWorker(CollectorDriverEvent)
  # Add tasks for device
  abstract def appendTask(deviceTasks : CollectorDeviceTasks) : Void

  # Incoming event
  def onEvent(event : CollectorDriverEvent) : Void
    case event
    when AddTaskEvent
      appendTask(event.deviceTasks)
    end
  end

  # Notify task complete
  def notifyTaskComplete(taskId : Int32) : Void
    addEvent(
      TaskCompleteEvent.new(taskId)
    )
  end

  # Notify task complete
  def notifyData(taskId : Int32) : Void
    addEvent(
      TaskDataEvent.new(taskId)
    )
  end
end

# # Base collector drver
# abstract class CollectorDriver
#   # Channel for sending driver events
#   @eventChannel = Channel(DriverEvent).new

#   def initialize
#   end

#   # Add tasks for device
#   abstract def appendTask(deviceTasks : CollectorDeviceTasks) : Void

#   # Listen for driver event
#   # Blocks thread and wait
#   # If timeout sends timeout event
#   def listenEvent(timeout : Int32, &block : DriverEvent -> _)
#     timer = delay(timeout) do
#       @eventChannel.send(DriverTimeoutEvent.new)
#     end

#     event = @eventChannel.receive
#     timer.cancel
#     yield event
#   end

#   # Notify task complete
#   def notifyTaskComplete(taskId : Int32) : Void
#     spawn do
#       @eventChannel.send(
#         TaskCompleteEvent.new(taskId)
#       )
#     end
#   end

#   # Notify data from driver
#   def notifyData(taskId : Int32) : Void
#     spawn do
#       @eventChannel.send(
#         TaskDataEvent.new(taskId)
#       )
#     end
#   end
# end

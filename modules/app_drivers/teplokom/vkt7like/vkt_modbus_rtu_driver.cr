require "collector_common"
require "./common/vkt_executer_context"

module VktDriver
  include Collector
  include ModbusProtocol::ModbusRtu

  # Driver for VKT-7 and VKG-3
  class VktModbusRtuDriver < CollectorMeterDriver
    include DriverProtocolMixin(ModbusRtuProtocol)
    include DriverExecutionContextMixin(VktExecuterContext)
    registerDevice(Vkt7Meter)
    registerDevice(Vkg3Meter)

    # Return meter model
    private def getMeterModel(deviceInfo : DeviceInfo)
      return Vkt7Model.new(deviceInfo)
    end

    # Override execution context
    def getExecutionContext : ExecutionContext
      meterModel = getMeterModel(deviceInfo)
      return VktExecuterContext.new(deviceInfo, protocol, meterModel)
    end

    # Process read action
    def executeReadAction(action : CollectorActionTask) : Void
      case action.actionInfo.state
      when StateType::DateTime
        TimeReader.new(executionContext) do |time|
          notifyTaskEvent(ReadTimeResponseEvent.new(
            action.taskId,
            time
          ))
        end
      else
        raise NorthwindException.new("Unknown read action")
      end
    end
  end

  # include ModbusProtocol::ModbusRtu

  # # Driver for VKT-7 and VKG-3
  # class VktModbusRtuDriver < CollectorMeterDriver
  #   include CollectorDriverProtocol(ModbusRtuProtocol)
  #   include CollectorDriverExecuterContext(VktExecuterContext)

  #   registerDevice("Vkt7")
  #   registerDevice("Vkg3")

  #   # Process read action. Virtual
  #   def executeReadAction(action : CollectorActionTask) : Void
  #     case action.actionInfo.state
  #     when StateType::DateTime
  #       TimeReader.new(executerContext) do |time|
  #         notifyTaskEvent(ReadTimeResponseEvent.new(
  #           action.taskId,
  #           time
  #         ))
  #       end
  #     else
  #       raise NorthwindException.new("Unknown read action")
  #     end
  #   end

  #   # Process current value requests
  #   def executeCurrentValues(tasks : Array(CollectorDataTask)) : Void
  #     case deviceInfo
  #     when PipeDeviceInfo
  #       valueReader = ValueReader.new(deviceInfo, protocol, meterModel)
  #       tasks.each do |task|
  #         valueReader.addParameter(task.parameter)
  #       end

  #       valueReader.execute do |value|
  #         tasks.each do |task|
  #           if task.parameter == value.measureParameter
  #             notifyTaskEvent(TaskDataResponseEvent.new(
  #               task.taskId,
  #               value.value
  #             ))
  #           end
  #         end
  #       end
  #     end
  #   end

  #   # Process read archive
  #   def executeArchive(tasks : Array(CollectorDataTask)) : Void
  #     case deviceInfo
  #     when PipeDeviceInfo
  #       tasks.group_by { |x| MeasureParameterHelper.getProfileType(x.parameter) }.each do |profileType, tasks|
  #         # Get request min and max date
  #         startDate = (tasks.min_by? { |x| x.interval.startDate }).try &.interval.startDate
  #         endDate = (tasks.max_by? { |x| x.interval.endDate }).try &.interval.endDate
  #         # TODO: done task
  #         next if (startDate.nil?) || (endDate.nil?)

  #         profileReader = ProfileReader.new(deviceInfo, protocol, startDate, endDate, profileType)
  #         profileReader.execute do |responseValue|
  #           tasks.each do |task|
  #             if task.parameter == responseValue.measureParameter
  #               notifyTaskEvent(TaskDataResponseEvent.new(
  #                 task.taskId,
  #                 TimedDataValue.new(responseValue.value, responseValue.dateTime)
  #               ))
  #             end
  #           end
  #         end
  #       end
  #     end
  #   end
  # end
end

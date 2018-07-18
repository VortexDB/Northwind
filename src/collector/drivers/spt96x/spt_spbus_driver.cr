require "../../protocols/**"

module Spt96xDriver
  include Collector
  include SpbusProtocol

  # Driver for Logica SPT96x
  class SptSpbusDriver < CollectorMeterDriver
    include CollectorDriverProtocol(SpbusProtocol)

    registerDevice("Spt96x")
    registerDevice("Spt76x")

    def initialize
    end
    
    # TODO: refactor

    # # Prepare and execute read action
    # private def executeReadAction(deviceInfo : PipeMeterDeviceInfo, action : CollectorActionTask) : Void
    #   case action.actionInfo.state
    #   when StateType::DateTime
    #     TimeReader.new(protocol) do |time|
    #       # notifyData(action.taskId)
    #     end
    #   else
    #     raise NorthwindException.new("Unknown read action")
    #   end
    # end

    # # Prepare and execute write action
    # private def executeWriteAction(deviceInfo : PipeMeterDeviceInfo, action : CollectorActionTask) : Void
    # end

    # # Execute actions
    # private def executeActions(deviceInfo : PipeMeterDeviceInfo, tasks : Array(CollectorActionTask)) : Void
    #   tasks.each do |task|
    #     case task.actionInfo.action
    #     when StateAction::Read
    #       executeReadAction(deviceInfo, task)
    #     when StateAction::Write
    #       executeWriteAction(deviceInfo, task)
    #     else
    #       raise NorthwindException.new("Unknown action")
    #     end
    #   end
    # end

    # # Execute current value reading
    # private def executeCurrentValues(deviceInfo : PipeMeterDeviceInfo, tasks : Array(CollectorDataTask)) : Void
    #   return if (deviceInfo.deviceType != DeviceType::Pipe && deviceInfo.deviceType != DeviceType::Group)

    #   tastToRequest = Hash(RequestParameter, CollectorDataTask).new

    #   reader = ValueReader.new
    #   tasks.each do |task|
    #     parameter = RequestParameter.fromChannelCurrent(deviceInfo.pipeNumber, task.parameter)
    #     tastToRequest[parameter] = task
    #     reader.addParameter(parameter)
    #   end

    #   reader.execute(protocol) do |response|
    #     task = tastToRequest[response.request]?
    #     next if task.nil?
    #     notifyData(TaskDataEvent.new(task.taskId, response.value))
    #   end
    # end

    # # Execute archive reading
    # private def executeArchive(deviceInfo : PipeMeterDeviceInfo, tasks : Array(CollectorDataTask)) : Void
    #   # TODO: Make it work

    #   # Group by profile id      
    #   # groups = tasks.each.map { |x| { x, x.parameter.getArchiveId } }.group_by { |x| x[1] }
    #   # groups.each do |group|
    #   #   filteredTasks = group[1]
    #   #   minDate = (filteredTasks.min_by { |x| x.interval.startDate }).startDate
    #   #   maxDate = (filteredTasks.max_by { |x| x.interval.endDate }).endDate

    #   #   reader = ArchiveReader.new(minDate, maxDate, group[0])
    #   #   filteredTasks.each do |task|  
    #   #     parameter = RequestParameter.fromChannelCurrent(deviceInfo.pipeNumber, task.parameter)        
    #   #     reader.addParameter(parameter)
    #   #     reader.execute(@protocol) do |response|
            
    #   #     end
    #   #   end
    #   # end
    # end

    # # Execute device task
    # def appendTask(deviceTasks : CollectorDeviceTasks) : Void
    #   deviceInfo = getDeviceInfo(deviceTasks.device)    

    #   if deviceInfo.deviceType == DeviceType::Meter
    #     actions = deviceTasks.tasks.compact_map do |x|
    #       x if x.is_a?(CollectorActionTask)
    #     end

    #     executeActions(deviceInfo, actions) if !actions.empty?
    #   end

    #   if (deviceInfo.deviceType == DeviceType::Pipe && deviceInfo.deviceType == DeviceType::Group)
    #     current = Array(CollectorDataTask).new
    #     archive = Array(CollectorDataTask).new

    #     deviceTasks.tasks.each do |task|
    #       case task
    #       when CollectorDataTask
    #         if task.parameter.discret == DiscretType::None
    #           current << task
    #         else
    #           archive << task
    #         end
    #       else
    #       end
    #     end

    #     executeCurrentValues(deviceInfo, current) if !current.empty?
    #     executeArchive(deviceInfo, archive) if !current.empty?
    #   end
    # end
  end
end

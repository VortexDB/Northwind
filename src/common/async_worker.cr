# Async worker
abstract class AsyncWorker(T)
  # Channel for output events
  @outChannel = Channel(T | Exception).new

  # Channel for incoming events
  @incomingChan = Channel(T).new

  # Is working
  getter isWorking = false

  # Send event to listener
  protected def addEvent(event : T | Exception)
    @outChannel.send(event) if !@outChannel.closed?
  end

  # Virtual
  # To get incoming events
  protected def onEvent(event : T) : Void
  end

  # Main work
  # Executes on fiber
  protected def work : Void
  end

  # Start listen events or exceptions
  def listen(&block : (T | Exception) -> _)
    spawn do
      @isWorking = true
      begin
        while !@outChannel.closed?
          event = @outChannel.receive
          block.call(event)
          Fiber.yield
        end
      rescue
      end
      @isWorking = false
    end

    spawn do
      begin
        while !@incomingChan.closed?
          event = @incomingChan.receive
          onEvent(event)
        end
      rescue
      end
    end

    spawn do
      begin
        work
      rescue e : Exception
        block.call(e) if @isWorking
      end
    end
  end

  # Send event to stream
  def send(event : T) : Void
    spawn do
      begin         
        @incomingChan.send(event)
      rescue
      end
    end
  end

  # Cancel working
  def cancel : Void
    return if !@isWorking
    @outChannel.close
    @incomingChan.close
    @isWorking = false
  end
end

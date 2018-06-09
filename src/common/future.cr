# Future
class Future(T)
  # Channel
  @channel = Channel(T | Nil).new

  # Is future complete
  @complete = false

  # Error
  @error : Exception?

  # Result of future
  @result : T?

  # Block to catch
  @catchBlock : Proc(Exception, Void)?

  # Block on complete
  @completeBlock : (-> Void)?

  # Wait all futures
  def self.waitAll(*futures)
    return futures.map do |f|
      f.wait
    end
  end

  # Start delayed future
  def self.delayed(duration : Time::Span, &block : -> T) : Future(T)
    return Future(T).new do
      sleep duration.total_seconds
      block.call
    end
  end

  # Execute future on fiber
  private def run(&block : -> T)
    spawn do
      begin
        @result = block.call        
        @complete = true
        @channel.send(@result)
      rescue e : Exception
        @error = e
        @complete = true
        if catchBlock = @catchBlock
          catchBlock.call(e)
        else
          raise e
        end
      ensure
        @channel.close
      end
    end
  end

  # Constructor
  def initialize(&block : -> T)
    run(&block)
  end

  # Future after
  def then(&block : T? -> _) : Future
    return Future.new do
      block.call(self.wait)
    end
  end

  # Future after
  def then!(&block : T -> _) : Future
    return Future.new do
      block.call(self.wait!)
    end
  end

  # Catch exception
  def catch(&block : Exception -> _) : Future
    @catchBlock = block
    self
  end

  # On complete with result o not
  def whenComplete(&block : -> _) : Future
    return Future.new do
      begin
        self.wait
      rescue e : Exception
        raise e
      ensure
        block.call
      end
      Nil
    end
  end

  # Wait for result with possible nil
  def wait : T?
    @channel.receive
  end

  # Wait for result without nil
  def wait! : T
    wait.not_nil!
  end
end

# Future with benchmarking
class FutureBench(T) < Future(T)
  # Start time
  @startTime : Time::Span?

  # End time
  @endTime : Time::Span?

  # Sure startTime
  def startTime! : Time::Span
    @startTime.not_nil!
  end

  # Sure endTime
  def endTime! : Time::Span
    @endTime.not_nil!
  end

  # Sure complete time
  def completeTime! : Time::Span
    endTime! - startTime!
  end

  # Overrided run
  protected def run(&block : -> T)
    @startTime = Time.monotonic
    super(&block)
  end

  def initialize(&block : -> T)
    super(&block)
  end

  # Overrided wait
  def wait : T?
    @endTime = Time.monotonic
    super
  end
end

# Future completer
class Completer(T)
  # Future to complete
  getter future : Future(T)

  # Channel to complete
  @channel : Channel(T)

  def initialize
    @channel = Channel(T).new

    @future = Future(T).new do
      value = @channel.receive
      value
    end
  end

  # Complete future
  def complete(value : T) : Void
    @channel.send(value)
  end
end

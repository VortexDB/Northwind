module Spt96xDriver
  # Current value data info
  struct ValueData
    # Request info
    getter request : RequestParameter

    # Value
    getter value : Float64

    def initialize(@request, @value)      
    end
  end

  # Read current value from device/pipe/group
  class ValueReader
    # Requests
    @requests : Set(RequestParameter)

    def initialize
      @requests = Set(RequestParameter).new
    end

    # Add request parameter
    def addParameter(parameter : RequestParameter) : Void
      @requests.add(parameter)
    end

    # Send request and read
    def execute(protocol : Protocol, &block : ValueData -> _) : Void
      reader = ParameterReader.new(protocol)
      @requests.each do |param|
        reader.addParameter(param)
      end

      values = reader.execute
      values.each do |item|
        # scaler = value.value
        data = item.data.value.to_f64
        block.call(          
          ValueData.new(item.parameter, data)
        )
      end
    end
  end
end

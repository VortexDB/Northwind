module Spt96xDriver
    # Parameter used for request
    class RequestParameter
        # Channel number(pipe)
        getter channel : String

        # Measure parameter number
        getter parameter : String

        # Return request parameter from channel and measure parameter for current values
        def self.fromChannelCurrent(channel : Int32, parameter : MeasureParameter) : RequestParameter
            chan = channel.to_s
            case parameter.measureType
            when MeasureType::ABSOLUTE_PRESSURE
                return RequestParameter.new(chan, "154")
            else
                raise NorthwindException.new("Unknown measure type")
            end
        end

        def initialize(@channel, @parameter)            
        end        
    end
end
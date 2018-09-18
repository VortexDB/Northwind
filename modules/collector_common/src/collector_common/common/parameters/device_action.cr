module Device
  # Action for a state
  enum StateAction
    # Read date time
    ReadDateTime,
    # Write date time
    WriteDateTime
  end

  # Action with state
  class DeviceAction    
    # Action
    getter action : StateAction

    def initialize(@action)
    end
  end
end

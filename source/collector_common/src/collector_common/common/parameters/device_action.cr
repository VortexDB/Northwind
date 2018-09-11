module Device
  # State type to read/write
  enum StateType
    DateTime
  end

  # Action for a state
  enum StateAction
    Read,
    Write
  end

  # Action with state
  class DeviceAction
    # State
    getter state : StateType

    # Action
    getter action : StateAction

    def initialize(@state, @action)
    end
  end
end

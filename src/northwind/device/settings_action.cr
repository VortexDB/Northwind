# State to read/write
enum SettingsState
    DateTime
end

# Action for a state
enum StateAction
    Read,
    Write
end

# Action with state
class SettingsAction
    # State
    getter state : SettingsState

    # Action
    getter action : StateAction

    def initialize(@state, @action)        
    end
end
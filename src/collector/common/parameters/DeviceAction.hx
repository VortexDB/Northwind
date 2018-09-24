package collector.common.parameters;

/**
 *  Action for a state
 */
enum StateAction {
	/**
	 * Read date time
	 */
	ReadDateTime;

	/**
	 * Write date time
	 */
	WriteDateTime;
}

/**
 * Action on device
 */
class DeviceAction {
	/**
	 * Action on device
	 */
	public final action:StateAction;

	/**
	 * Constructor
	 * @param action 
	 */
	public function new(action:StateAction) {
		this.action = action;
	}

    /**
	 * Calc hash
	 * @return Int
	 */
	public function hashCode():Int {
		return action.getIndex();
	}

	/**
	 * Compare objects
	 * @param other
	 * @return Bool
	 */
	public function equals(other:Dynamic):Bool {
		if (Std.is(other, DeviceAction)) {
			return hashCode() == cast(other, DeviceAction).hashCode();
		}

		return false;
	}
}

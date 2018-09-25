package collector.common.parameters;

/**
 *  Action for a state
 */
enum ActionType {
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
	public final actionType:ActionType;

	/**
	 * Constructor
	 * @param action 
	 */
	public function new(actionType:ActionType) {
		this.actionType = actionType;
	}

    /**
	 * Calc hash
	 * @return Int
	 */
	public function hashCode():Int {
		return actionType.getIndex();
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

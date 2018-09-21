package collector.common.appdriver;

using core.utils.StringHelper;

/**
 * Collects data from devices
 */
class CollectorDriver {
	/**
	 * Name of script
	 */
	public final name:String;

	/**
	 * Constructor
	 * @param name
	 */
	public function new(name:String) {
		this.name = name;
	}

	/**
	 * Calc hash
	 * @return Int
	 */
	public function hashCode():Int {
		return name.hashCode();
	}

	/**
	 * Compare objects
	 * @param other
	 * @return Bool
	 */
	public function equals(other:Dynamic):Bool {
		if (Std.is(other, CollectorDriver)) {
			return name == cast(other, CollectorDriver).name;
		}

		return false;
	}
}

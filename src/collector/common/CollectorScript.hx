package collector.common;

using core.utils.StringHelper;

/**
 * Collects data from app layer drivers
 */
class CollectorScript {
	/**
	 * Name of script
	 */
	public final name:String;

	/**
	 * Devices to collect data
	 */
	public final devices:HashSet<CollectorDevice>;

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
		if (Std.is(other, CollectorScript)) {
			return name == cast(other, CollectorScript).name;
		}

		return false;
	}

	/**
	 * Start execute script
	 */
	public function start() {}
}

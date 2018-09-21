package collector.common;

import haxe.Timer;
import core.time.TimeSpan;
import core.time.schedule.ISchedule;
import core.collections.HashSet;
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
	 * Schedule to get time of launch
	 */
	public final schedule:ISchedule;

	/**
	 * Devices to collect data
	 */
	public final devices:HashSet<CollectorDevice>;

	/**
	 * Constructor
	 * @param name
	 */
	public function new(name:String, schedule: ISchedule) {
		this.name = name;
		this.devices = new HashSet<CollectorDevice>();
		this.schedule = schedule;
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
	 * Add collector device
	 */
	public function addDevice(device:CollectorDevice) {
		devices.add(device);
	}

	/**
	 * Start execute script
	 */
	public function start() {
		var span = schedule.nextStart();
		var seconds = span.totalMilliseconds;
	}
}

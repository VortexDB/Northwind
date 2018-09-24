package collector.common;

import haxe.Log;
import haxe.Timer;
import collector.common.parameters.MeasureParameter;
import collector.common.parameters.DeviceAction;
import core.time.TimeSpan;
import core.time.schedule.ISchedule;
import core.collections.HashSet;

using core.utils.StringHelper;

/**
 * Collects data from app layer drivers
 */
class CollectorScript {
	/**
	 * Default deep in days
	 */
	public static inline var DEFAULT_DEEP = 3;

	/**
	 * Name of script
	 */
	public final name:String;

	/**
	 * Schedule to get time of launch
	 */
	public final schedule:ISchedule;

	/**
	 * Deep of data to collect in days
	 */
	public final deep:Int;

	/**
	 * Devices to collect data
	 */
	public final devices:HashSet<CollectorDevice>;

	/**
	 * Measure parameters to collect
	 */
	public final parameters:HashSet<MeasureParameter>;

	/**
	 * Actions on devices
	 */
	public final actions:HashSet<DeviceAction>;

	/**
	 * Waiting for start and start collect
	 */
	private function startSchedule() {
		var span = schedule.nextStart();
		Log.trace('Script: ${name}');
		Log.trace('Next start: ${span}');
		var ms = Math.floor(span.totalMilliseconds);
		Timer.delay(() -> {
			startCollect();
			// Launch again
			startSchedule();
		}, ms);
	}

	/**
	 * Start collect from device
	 */
	private function startCollect() {		
		Log.trace('Device count: ${devices.length}');
		Log.trace('Parameters: ${parameters.length}');
		Log.trace('Actions: ${actions.length}');
		Log.trace('Deep: ${deep}');
	}

	/**
	 * Constructor
	 * @param name
	 */
	public function new(name:String, schedule:ISchedule, deep:Int = DEFAULT_DEEP) {
		this.deep = deep;
		this.name = name;
		this.parameters = new HashSet<MeasureParameter>();
		this.actions = new HashSet<DeviceAction>();
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
		startSchedule();
	}
}

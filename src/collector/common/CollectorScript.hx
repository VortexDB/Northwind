package collector.common;

import collector.common.CollectorWorker.DriverMapKey;
import haxe.Log;
import haxe.Timer;
import collector.common.parameters.MeasureParameter;
import collector.common.parameters.DeviceAction;
import core.time.schedule.ISchedule;
import core.collections.HashSet;

using core.utils.StringHelper;
using core.utils.IterableHelper;

/**
 * Collects data from app layer drivers
 */
class CollectorScript {
	/**
	 * Default deep in days
	 */
	public static inline var DEFAULT_DEEP = 3;

	/**
	 * Owner of script
	 */
	private final owner:CollectorWorker;

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

		var routeDeviceGroups = devices.groupdBy((e) -> {
			return e.route;
		});

		for (route in routeDeviceGroups.keys()) {
			// Get channel
			// Open channel if it's a ClientChannel

			var routeDevices = routeDeviceGroups[route];
			for (device in routeDevices) {
				var driverKey = new DriverMapKey(device.deviceType, device.protocolType);
				var driver = owner.getDriver(driverKey);
				trace(driver);
			}
			// Get driver by deviceType and protocolType

			// Close channel if it's a ClientChannel
		}
	}

	/**
	 * Constructor
	 * @param name
	 */
	public function new(owner:CollectorWorker, name:String, schedule:ISchedule, deep:Int = DEFAULT_DEEP) {
		this.owner = owner;
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
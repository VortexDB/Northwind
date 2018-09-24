package collector.common;

import haxe.Log;
import haxe.ds.HashMap;
import core.time.schedule.ISchedule;
import core.collections.HashSet;
import collector.common.appdriver.CollectorDriver;
import collector.common.CollectorScript;

using core.utils.StringHelper;

/**
 * Key for map of device driver
 */
class DriverMapKey {
	/**
	 * Device type
	 */
	public final deviceType:String;

	/**
	 * Protocol type
	 */
	public final protocolType:String;

	/**
	 * Constructor
	 */
	public function new(deviceType:String, protocolType:String) {
		this.deviceType = deviceType;
		this.protocolType = protocolType;
	}

	/**
	 * Calc hash
	 * @return Int
	 */
	public function hashCode():Int {
		return deviceType.hashCode() ^ protocolType.hashCode();
	}

	/**
	 * Compare objects
	 * @param other
	 * @return Bool
	 */
	public function equals(other:Dynamic):Bool {
		if (Std.is(other, DriverMapKey)) {
			return hashCode() == cast(other, DriverMapKey).hashCode();
		}

		return false;
	}

	/**
	 * Convert to string
	 * @return String
	 */
	public function toString():String {
		return 'DeviceType: ${deviceType} ProtocolType: ${protocolType}';
	}
}

/**
 * Main working class of Collector that launches collector scripts
 */
class CollectorWorker {
	/**
	 * Is collector working
	 */
	private var isWorking:Bool;

	/**
	 * Scripts that collects data
	 */
	private final scripts:HashSet<CollectorScript>;

	/**
	 * Known drivers that can collect data
	 */
	private final drivers:HashMap<DriverMapKey, CollectorDriver>;

	/**
	 * Constructor
	 */
	public function new() {
		scripts = new HashSet<CollectorScript>();
		drivers = new HashMap<DriverMapKey, CollectorDriver>();
		isWorking = false;
	}

	/**
	 * Create new script for collecting data, and puts in to scripts hash set
	 * @return CollectorScript
	 */
	public function newScript(name:String, schedule:ISchedule):CollectorScript {
		var script = new CollectorScript(this, name, schedule);
		scripts.add(script);
		return script;
	}

	/**
	 * Register collector driver in known driver map
	 * @param driver - class of CollectorDriver
	 */
	public function registerDriver(driver:Class<Dynamic>) {
		var driverInstance = cast(Type.createInstance(driver, []), CollectorDriver);
		for (devType in driverInstance.deviceTypes) {
			var className = Type.getClassName(Type.getClass(driverInstance.protocol));
			var nameItems = className.split(".");
			var protocol = nameItems[nameItems.length - 1];
			var driverKey = new DriverMapKey(devType, protocol);
			drivers.set(driverKey, driverInstance);
		}
	}

	/**
	 * Get driver by it's key
	 * @param driverKey 
	 */
	public function getDriver(driverKey:DriverMapKey) {
		return drivers.get(driverKey);
	}

	/**
	 * Start collector
	 */
	public function start() {
		isWorking = true;
		Log.trace("Starting scripts");
		Log.trace('Script count: ${scripts.length}');
		//while (isWorking) {
			for (script in scripts) {
				script.start();
			}
		//}
	}
}

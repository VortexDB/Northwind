package collector.common;

import haxe.Log;
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
	private final drivers:Map<DriverMapKey, CollectorDriver>;

	/**
	 * Constructor
	 */
	public function new() {
		scripts = new HashSet<CollectorScript>();
		drivers = new Map<DriverMapKey, CollectorDriver>();
		isWorking = false;
	}

	/**
	 * Create new script for collecting data, and puts in to scripts hash set
	 * @return CollectorScript
	 */
	public function newScript(name:String, schedule:ISchedule):CollectorScript {
		var script = new CollectorScript(name, schedule);
		scripts.add(script);
		return script;
	}

	/**
	 * Register collector driver in known driver map
	 * @param driver - class of CollectorDriver
	 */
	public function registerDriver(driver:Class<Dynamic>) {
		var driverInstance = cast(Type.createInstance(driver, []), CollectorDriver);
		trace(driverInstance.deviceTypes);
		//var driverKey = new DriverMapKey();
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

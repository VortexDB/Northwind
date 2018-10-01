package collector.common;

import collector.common.appdriver.CollectorMeterDriver;
import collector.common.appdriver.ExecutionContext;
import collector.common.appdriver.IDriverWithExecutionContext;
import core.time.TimeSpan;
import core.time.DateTime;
import haxe.Log;
import haxe.Timer;
import core.time.schedule.ISchedule;
import core.collections.HashSet;

using core.utils.StringHelper;
using core.utils.IterableHelper;

import collector.common.CollectorWorker.DriverMapKey;
import collector.common.appdriver.CollectorDriver;
import collector.common.task.CollectorDeviceTasks;
import collector.common.task.CollectorDataTask;
import collector.common.task.CollectorTask;
import collector.common.task.CollectorActionTask;
import collector.common.parameters.MeasureParameter;
import collector.common.parameters.DeviceAction;
import collector.common.parameters.DateInterval;
import collector.common.route.DeviceRoute;
import collector.common.route.DirectSerialRoute;
import collector.common.channel.TransportChannel;
import collector.common.channel.ClientTransportChannel;
import collector.channels.serial.SerialDirectChannel;

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
	 * Get channel for route
	 * @param route
	 */
	private function getChannelByRoute(route:DeviceRoute):TransportChannel {
		if ((route is DirectSerialRoute)) {
			return new SerialDirectChannel(route);
		}
		return null;
	}

	/**
	 * Waiting for start and start collect
	 */
	private function startSchedule() {
		var span = schedule.nextStart();
		Log.trace('Script: ${name}');
		Log.trace('Next start: ${span}');
		var ms = Math.floor(span.totalMilliseconds);
		Timer.delay(() -> {
			var stamp = Timer.stamp();
			startCollect();
			stamp = Timer.stamp() - stamp;
			Log.trace('Executed: ${stamp} seconds');
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
			var channel = getChannelByRoute(route);
			var clientChannel:ClientTransportChannel = cast channel;
			// Open channel if it's a ClientChannel
			if (clientChannel != null)
				clientChannel.open(1000);

			var routeDevices = routeDeviceGroups[route];
			// For grouping by driver key
			var driverKeys = new Array<DriverMapKey>();

			for (device in routeDevices) {
				var driverKey = new DriverMapKey(device.deviceType, device.protocolType);
				driverKeys.push(driverKey);
			}

			var driverKeyGroups = driverKeys.groupdBy((e) -> {
				return e.hashCode();
			});

			for (driverKey in driverKeyGroups) {
				var first = driverKey[0];
				var driver = owner.getDriver(first);
				driver.protocol.channel = channel;
				collectByDriver(driver, routeDevices);
			}

			// Close channel if it's a ClientChannel
			if (clientChannel != null)
				clientChannel.close();
		}
	}

	/**
	 * Collect data by driver
	 * @param driver
	 * @param devices
	 */
	private function collectByDriver(driver:CollectorDriver, devices:Array<CollectorDevice>) {
		var now = DateTime.now();
		var startDate = now + new TimeSpan({
			days: deep
		});
		var endTime = now;

		var interval = new DateInterval(startDate, endTime);
		var tasks = new Array<CollectorTask>();

		for (device in devices) {
			for (action in actions) {
				tasks.push(new CollectorActionTask(action));
			}

			for (parameter in parameters) {
				tasks.push(new CollectorDataTask(parameter, interval));
			}

			var meterDriver:CollectorMeterDriver = cast driver;
			if (meterDriver != null) {
				// Create device info
				meterDriver.deviceInfo = meterDriver.getDeviceInfo(device);
				// Create execution context
				var driverWithContext:IDriverWithExecutionContext<ExecutionContext> = cast driver;
				if (driverWithContext != null) {
					driverWithContext.executionContext = driverWithContext.createExecutionContext(meterDriver.deviceInfo, driver.protocol);
				}
			}

			driver.appendTask(new CollectorDeviceTasks(device, tasks));
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
	 * Add device action
	 * @param action
	 */
	public function addAction(action:DeviceAction) {
		actions.add(action);
	}

	/**
	 * Add measure parameter
	 * @param action
	 */
	public function addParameter(parameter:MeasureParameter) {
		parameters.add(parameter);
	}

	/**
	 * Start execute script
	 */
	public function start() {
		startSchedule();
	}
}

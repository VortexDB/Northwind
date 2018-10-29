package collector.common.collect;

import core.async.future.Future;
import haxe.Log;
import haxe.Timer;
import core.time.schedule.ISchedule;
import core.collections.HashSet;
import collector.common.util.NorthwindException;
import collector.common.appdriver.DriverMapKey;
import collector.common.appdriver.CollectorDriver;
import collector.common.parameters.MeasureParameter;
import collector.common.parameters.DeviceAction;
import collector.common.route.DeviceRoute;
import collector.common.route.DirectSerialRoute;
import collector.common.channel.TransportChannel;
import collector.channels.serial.SerialDirectChannel;
import collector.common.appdriver.event.ReadTimeResponseEvent;
import collector.common.appdriver.event.CollectorDriverEvent;

using core.utils.StringHelper;
using core.utils.IterableHelper;

/**
 * State of script
 */
enum CollectorScriptState {
	/**
	 * Script is stopped and ready for launch
	 */
	Stoped;

	/**
	 * Launched and waiting for start by schedule
	 */
	Waiting;

	/**
	 * Script is working and collecting data
	 */
	Working;
}

/**
 * Collects data from app layer drivers
 */
class CollectorScript implements IScriptContext {
	/**
	 * Default deep in days
	 */
	public static inline var DEFAULT_DEEP = 3;

	/**
	 * Future that completes when all colecting is done
	 */
	private var scriptDoneCompleter:CompletionFuture<Bool>;

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
	 * Current state of script
	 */
	public var state:CollectorScriptState;

	/**
	 * Return future that will completed when script will be stopped
	 */
	private function stopInternal():Future<Bool> {
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
		this.state = CollectorScriptState.Waiting;
		Timer.delay(()
			-> {
				var stamp = Timer.stamp();
				scriptDoneCompleter = new CompletionFuture<Bool>();
				scriptDoneCompleter.onSuccess((_)
					-> {
						stamp = Timer.stamp() - stamp;
						Log.trace('Executed: ${stamp} seconds');
						// Launch again
						startSchedule();
					}).onError((ex) -> {
					trace(ex);
				});
				startCollect();
			},
			ms);
	}

	/**
	 * Start collect from device
	 */
	private function startCollect() {
		if (state == CollectorScriptState.Working)
			throw new NorthwindException("Script already in work");

		state = CollectorScriptState.Working;
		Log.trace('Device count: ${devices.length}');
		Log.trace('Parameters: ${parameters.length}');
		Log.trace('Actions: ${actions.length}');
		Log.trace('Deep: ${deep}');

		var routeDeviceGroups = devices.groupdBy((e) -> {
			return e.route;
		});

		collectByRoutes(routeDeviceGroups);
	}

	/**
	 * Collect data by routes
	 */
	private function collectByRoutes(routeDeviceGroups:Map<DeviceRoute, Array<CollectorDevice>>) {
		var states = [];
		for (route in routeDeviceGroups.keys()) {
			var routeDevices = routeDeviceGroups[route];
			var routeCollector = new RouteCollector(this, route, routeDevices);
			routeCollector.collect().onSuccess((_) -> {
				states.push(1);
			});
		}

		return null;
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
		this.state = CollectorScriptState.Stoped;
	}

	/**
     * Get collect deep
     * @return Int
     */
    public function getDeep():Int {
		return deep;
	}

    /**
     * Get actions to execute
     * @return Array<DeviceAction>
     */
    public function getActions():HashSet<DeviceAction> {
		return actions;
	}

    /**
     * Get parameters to read
     * @return Array<DeviceAction>
     */
    public function getParameters():HashSet<MeasureParameter> {
		return parameters;
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

	/**
	 * Stop execution
	 */
	public function stop():Future<Bool> {
		return stopInternal();
	}

	/**
     * Get channel by route
     * @param route 
     */
    public function getChannelByRoute(route:DeviceRoute):TransportChannel {
		if ((route is DirectSerialRoute)) {
			return new SerialDirectChannel(route);
		}
		return null; 
	}

    /**
     * Return collector driver by driver key
     * @param key 
     * @return CollectorDriver
     */
    public function getDriver(key:DriverMapKey):CollectorDriver {
		return owner.getDriver(key);
	}
}

package collector.common.collect;

import collector.common.appdriver.ExecutionContext;
import collector.common.task.CollectorActionTask;
import collector.common.task.CollectorDataTask;
import collector.common.appdriver.IDriverWithExecutionContext;
import collector.common.appdriver.CollectorMeterDriver;
import collector.common.task.CollectorDeviceTasks;
import collector.common.task.CollectorTask;
import haxe.ds.HashMap;
import core.time.TimeSpan;
import core.time.DateTime;
import core.async.future.Future;
import collector.common.appdriver.event.CollectorDriverEvent;
import collector.common.appdriver.event.ReadTimeResponseEvent;
import collector.common.parameters.DateInterval;
import collector.common.appdriver.CollectorDriver;

/**
 * Execution context for driver
 */
class DriverCollectorContext {
	/**
	 * All tasks by device
	 */
	private final tasksByDevice:HashMap<CollectorDevice, Map<Int, CollectorTask>>;

	/**
	 * Collector driver
	 */
	public final driver:CollectorDriver;

	/**
	 * Constructor
	 */
	public function new(driver:CollectorDriver) {
		this.driver = driver;
		this.tasksByDevice = new HashMap<CollectorDevice, Map<Int, CollectorTask>>();
	}

	/**
	 * Add tasks for device
	 * @param deviceTasks
	 */
	public function appendTask(deviceTasks:CollectorDeviceTasks) {
		var tasks = tasksByDevice.get(deviceTasks.device);
		if (tasks == null) {
			tasks = new Map<Int, CollectorTask>();
			tasksByDevice.set(deviceTasks.device, tasks);
		}

		for (task in deviceTasks.tasks) {
			tasks.set(task.taskId, task);
		}
	}
}

/**
 * Collects data from driver by devices
 */
class DriverCollector {
    /**
     * Future that completes on collection over or error
     */
    private final completer:CompletionFuture<DriverCollector>;

    /**
	 * Context of collector script
	 */
	public final owner:IScriptContext;

    /**
     * Driver that collects data
     */
    public final driver:CollectorDriver;

    /**
     * Devices of driver
     */
    public final driverDevices:Array<CollectorDevice>;

    /**
     * Constructor
     * @param driver 
     * @param driverDevices 
     */
    public function new(owner:IScriptContext, driver:CollectorDriver, driverDevices:Array<CollectorDevice>) {
        this.owner = owner;
        this.driver = driver;
        this.driverDevices = driverDevices;
        this.completer = new CompletionFuture<DriverCollector>();
    }

    /**
	 * Process events from driver
	 */
	private function processDriverEvent(context:DriverCollectorContext, event:CollectorDriverEvent) {
		var timeEvent:ReadTimeResponseEvent = cast event;
		if (timeEvent != null) {
			trace(timeEvent.value);
		}

		completer.complete(this);
	}

    /**
     * Return future that will be completed when 
     * @return Future<Bool>
     */
    public function collect():Future<DriverCollector> {
        var driverName = Type.getClassName(Type.getClass(driver));
		trace('CollectByDriver ${driverName}');
		var now = DateTime.now();
		var startDate = now + new TimeSpan({
			days: owner.getDeep()
		});
		var endTime = now;

		var interval = new DateInterval(startDate, endTime);

		var driverContext = new DriverCollectorContext(driver);

		// Process driver event
		driver.onEvent.listen((ev) -> {
			processDriverEvent(driverContext, ev);
		});

		for (device in driverDevices) {
			var tasks = new Array<CollectorTask>();

			for (action in owner.getActions()) {
				tasks.push(new CollectorActionTask(action));
			}

			for (parameter in owner.getParameters()) {
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

			try {
				var deviceTask = new CollectorDeviceTasks(device, tasks);
				driver.appendTask(deviceTask);
				driverContext.appendTask(deviceTask);
			} catch (e:Dynamic) {
				trace(e);
			}
		}
        
        return completer;
    }
}
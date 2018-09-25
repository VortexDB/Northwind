package collector.common.appdriver;

import collector.common.parameters.Discret.DiscretType;
import collector.common.task.CollectorDataTask;
import collector.common.task.CollectorDeviceTasks;
import collector.common.task.CollectorActionTask;
import collector.common.appdriver.deviceinfo.*;

using core.utils.IterableHelper;

/**
 * Driver for smart meters
 */
class CollectorMeterDriver extends CollectorDriver {
	/**
	 * Information of current device
	 */
	private var deviceInfo:DeviceInfo;

	/**
	 * Return device info from device
	 * Can be overrided for creating own device info
	 * @param device
	 * @return MeterDeviceInfo
	 */
	private function getDeviceInfo(device:CollectorDevice):MeterDeviceInfo {
		return null;
		//   # TODO: Get this information from database
		//   case device.dataSource
		//   when PipeDataSource
		//     return PipeDeviceInfo.new(1, 1)
		//   when MeterDataSource
		//     return MeterDeviceInfo.new
		//   else
		//     raise NorthwindException.new("Unknown device type")
		//   end
	}

	/**
	 * Execute before all task execution for device. Virtual
	 */
	public function executeBefore():Void {}

	/**
	 * Execute after all task execution for device. Virtual
	 */
	public function executeAfter():Void {}

	/**
	 * Process execute actions. Virtual
	 * @param action
	 */
	public function executeActions(actions:Array<CollectorActionTask>):Void {}

	/**
	 * Process read current values. Virtual
	 * @param tasks
	 * @return ) : Void
	 */
	public function executeCurrentValues(tasks:Array<CollectorDataTask>):Void {}

	/**
	 * Process read archive. Virtual
	 * @param tasks
	 * @return ) : Void
	 */
	public function executeArchive(tasks:Array<CollectorDataTask>):Void {}

	/**
	 * Execute device task
	 * @param deviceTasks
	 */
	public override function appendTask(deviceTasks:CollectorDeviceTasks):Void {
		deviceInfo = getDeviceInfo(deviceTasks.device);
		var actions = new Array<CollectorActionTask>();
		var current = new Array<CollectorDataTask>();
		var acrhive = new Array<CollectorDataTask>();

		for (task in deviceTasks.tasks) {
			if (Std.is(task, CollectorActionTask)) {
				actions.push(cast task);
			} else if (Std.is(task, CollectorDataTask)) {
				var dataTask:CollectorDataTask = cast task;
				if (dataTask.parameter.discret.discretType == DiscretType.None) {
					current.push(dataTask);
				} else {
					acrhive.push(dataTask);
				}
			}
		}

		executeBefore();
		if (actions.length > 0)
			executeActions(actions);
		if (current.length > 0)
			executeCurrentValues(current);
		if (acrhive.length > 0)
			executeArchive(acrhive);

		executeAfter();
	}
}

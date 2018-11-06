package collector.common.appdriver.event;

import collector.common.task.CollectorTask;

/**
 * Task complete event
 */
class DriverTaskCompleteEvent extends CollectorDriverEvent {
	/**
	 * Task
	 */
	public final taskId:Int;

	/**
	 * Constructor
	 */
	public function new(taskId:Int) {
		this.taskId = taskId;
	}
}

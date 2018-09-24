package collector.common.task;

/**
 * Task that executes on device: collect data, execute action
 */
class CollectorTask {
	/**
	 * Counter of identifier
	 */
	public static var counter:Int = 1;

	/**
	 * Identifier of task
	 */
	public final taskId:Int;

	/**
	 * Constructor
	 */
	public function new() {
		this.taskId = CollectorTask.counter;
		CollectorTask.counter += 1;
	}
}

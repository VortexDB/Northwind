package collector.common.task;

/**
 * Tasks by device
 */
class CollectorDeviceTasks {
	/**
	 * Device to collect data
	 */
	public final device:CollectorDevice;

	/**
	 * Tasks for device
	 */
	public final tasks:Array<CollectorTask>;

	/**
	 * Constructor
	 * @param device
	 * @param tasks
	 */
	public function new(device:CollectorDevice, tasks:Array<CollectorTask>) {
		this.device = device;
		this.tasks = tasks;
	}
}

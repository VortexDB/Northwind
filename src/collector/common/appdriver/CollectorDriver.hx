package collector.common.appdriver;

import collector.common.task.CollectorDeviceTasks;

/**
 * Collects data from devices
 */
class CollectorDriver {
	/**
	 * Devices that can be processed by driver
	 */
	public final deviceTypes:Array<String>;

	/**
	 * Transport protocol
	 */
	public final protocol:TransportProtocol;

	/**
	 * Constructor
	 */
	public function new(deviceTypes:Array<String>, protocol:TransportProtocol) {
		this.deviceTypes = deviceTypes;
		this.protocol = protocol;
	}

	/**
	 * Add tasks for device
	 * For override
	 * @param deviceTasks
	 */
	public function appendTask(deviceTasks:CollectorDeviceTasks):Void {}
}

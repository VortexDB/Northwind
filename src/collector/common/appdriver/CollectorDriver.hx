package collector.common.appdriver;

import core.time.DateTime;
import collector.common.task.CollectorDeviceTasks;
import collector.common.protocol.TransportProtocol;
import collector.common.appdriver.event.CollectorDriverEvent;
import collector.common.appdriver.event.ReadTimeResponseEvent;

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
	 * Notify about some event on taks
	 */
	public function notifyTaskEvent(event:CollectorDriverEvent) {
	}

	/**
	 * Add tasks for device
	 * For override
	 * @param deviceTasks
	 */
	public function appendTask(deviceTasks:CollectorDeviceTasks):Void {}
}

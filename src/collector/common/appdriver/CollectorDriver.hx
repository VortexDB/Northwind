package collector.common.appdriver;

import core.async.stream.Stream;
import core.async.stream.StreamController;
import collector.common.task.CollectorDeviceTasks;
import collector.common.protocol.TransportProtocol;
import collector.common.appdriver.event.CollectorDriverEvent;

/**
 * Collects data from devices
 */
class CollectorDriver {
	/**
	 * Controller for on event stream
	 */
	private final onEventController:StreamController<CollectorDriverEvent>;

	/**
	 * Devices that can be processed by driver
	 */
	public final deviceTypes:Array<String>;

	/**
	 * Transport protocol
	 */
	public final protocol:TransportProtocol;

	/**
	 * On driver event
	 */
	public final onEvent:Stream<CollectorDriverEvent>;

	/**
	 * Constructor
	 */
	public function new(deviceTypes:Array<String>, protocol:TransportProtocol) {
		this.deviceTypes = deviceTypes;
		this.protocol = protocol;
		this.onEventController = new StreamController<CollectorDriverEvent>();
		this.onEvent = this.onEventController.stream;
	}

	/**
	 * Notify about some event on taks
	 */
	public function notifyTaskEvent(event:CollectorDriverEvent) {
		onEventController.add(event);
	}

	/**
	 * Add tasks for device
	 * For override
	 * @param deviceTasks
	 */
	public function appendTask(deviceTasks:CollectorDeviceTasks):Void {}
}

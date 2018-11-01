package collector.common.channel;

import core.async.future.Future;
import collector.common.route.DeviceRoute;

/**
 * Base transport channel
 */
class TransportChannel {
	/**
	 * Route to device
	 */
	public final route:DeviceRoute;

	/**
	 * Constructor
	 * @param route
	 */
	public function new(route:DeviceRoute) {
		this.route = route;
	}

	/**
	 * Open channel with timeout in milliseconds
	 */
	public function open(timeout:Int):Future<Bool> {
		throw "Not implemented";
	}

	/**
	 * Close channel
	 */
	public function close():Future<Bool> {
		throw "Not implemented";
	}
}

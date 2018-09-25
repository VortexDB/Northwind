package collector.common;

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
	 * Open channel
	 */
	public function open(timeout:Int):Void {
		throw "Not implemented";
	}

	/**
	 * Close channel
	 */
	public function close():Void {
		throw "Not implemented";
	}
}

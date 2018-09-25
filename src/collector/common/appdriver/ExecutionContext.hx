package collector.common.appdriver;

import collector.common.appdriver.deviceinfo.DeviceInfo;

import collector.common.protocol.TransportProtocol;
/**
 * Abstract execution context for transfering it between driver and executers
 */
class ExecutionContext {
	/**
	 * Device information
	 */
	public final deviceInfo:DeviceInfo;

	/**
	 * Protocol information
	 */
	public final protocol:TransportProtocol;

	/**
	 * Constructor
	 * @param deviceInfo
	 * @param protocol
	 */
	public function new(deviceInfo:DeviceInfo, protocol:TransportProtocol) {
		this.deviceInfo = deviceInfo;
		this.protocol = protocol;
	}
}

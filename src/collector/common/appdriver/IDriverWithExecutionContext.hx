package collector.common.appdriver;

import collector.common.protocol.TransportProtocol;
import collector.common.appdriver.deviceinfo.DeviceInfo;
import collector.common.appdriver.ExecutionContext;

/**
 * Interface for driver that uses executers
 */
interface IDriverWithExecutionContext<T:ExecutionContext> {
	/**
	 * Execution context
	 */
	var executionContext:T;

	/**
	 * Create new execution context
	 * @return T
	 */
	function createExecutionContext(deviceInfo:DeviceInfo, protocol:TransportProtocol):T;
}

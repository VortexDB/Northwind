package collector.protocols.modbus.rtu;

import core.async.Future;
import collector.protocols.modbus.ModbusProtocol;

/**
 * Modbus Rtu protocol
 */
@:keep
class ModbusRtuProtocol extends ModbusProtocol {
	/**
	 * Constructor
	 */
	public function new() {}

	/**
	 * Send request and wait for response
	 * @param request
	 * @return ProtocolResponse
	 */
	public function sendRequestWithResponse(request:ModbusRtuRequest):ModbusRtuResponse {
        return null;
    }
}

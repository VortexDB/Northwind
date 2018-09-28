package collector.protocols.modbus.rtu;

import haxe.io.BytesBuffer;
import haxe.io.Bytes;
import collector.common.channel.IBinaryChannel;
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
		var chan = cast(channel, IBinaryChannel);
		var pdu = request.getData();
		var bytes = new BytesBuffer();

        return null;
    }
}

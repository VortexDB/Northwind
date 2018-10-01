package collector.protocols.modbus.rtu;

import core.io.BinaryData;
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
		var fullFrame = new BinaryData();
		// TODO: remove. It's VKT only
		fullFrame.addInt16(0xFFFF);

		var payload = new BinaryData();
		payload.addByte(request.networkAddress);
		payload.addByte(request.functionId());
		payload.addBytes(pdu);
		fullFrame.addBinaryData(payload);

		var crc = ModbusRtuCrcHelper.calcCrc(payload.toBytes());
		fullFrame.addInt16(crc);

		chan.write(fullFrame.toBytes());

        return null;
    }
}

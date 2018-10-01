package collector.protocols.modbus.rtu;

import core.utils.exceptions.TimeoutExeption;
import core.io.BinaryData;
import collector.common.channel.IBinaryChannel;
import collector.protocols.modbus.ModbusProtocol;
import collector.protocols.modbus.rtu.requests.ReadHoldingRegistersRequest;
import collector.protocols.modbus.rtu.requests.PresetMultipleRegistersRequest;

/**
 * Modbus Rtu protocol
 */
@:keep
class ModbusRtuProtocol extends ModbusProtocol {
	/**
	 * Network + FunctionId
	 */
	public static inline final HEADER_SIZE = 2;

	/**
	 * Network + FunctionId + Crc16
	 */
	public static inline final MIN_PACKET_SIZE = HEADER_SIZE + 2;

	/**
	 * Get answer length
	 */
	private function getAnswerLength(functionId:Int, buffer:BinaryData):Int {
		switch (functionId) {
			case ReadHoldingRegistersRequest.FUNCTION_ID:
				return buffer.getByte(ReadHoldingRegistersRequest.LENGTH_POS);
			case PresetMultipleRegistersRequest.FUNCTION_ID:
				return PresetMultipleRegistersRequest.RESPONSE_LENGTH;
		}

		return -1;
	}

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

		var binary = new BinaryData();
		var network = 0;
		var fullSize = 0;
		var functionId:Null<Int> = null;
		var lengthRead = false;
		var answerLength = -1;

		while (true) {
			try {
				var data = chan.read();
				if (data.length < 1)
					continue;

				fullSize += data.length;
				binary.addBytes(data);
				if (!lengthRead && fullSize >= HEADER_SIZE) {
					network = binary.getByte(0);
					functionId = binary.getByte(1);
				}

				if (functionId != null) {
					if (request.knownLength > 0) {
						answerLength = request.knownLength;
					} else {
						answerLength = getAnswerLength(functionId, binary);
					}
				}

				lengthRead = true;
				if (fullSize - MIN_PACKET_SIZE >= answerLength) {
					break;
				}
			} catch (e:TimeoutException) {
				break;
			}
		}

		trace(binary.toBytes().toHex());

		return null;
	}
}

package collector.protocols.modbus.rtu;

import core.async.stream.StreamController;
import core.time.TimeSpan;
import core.async.future.Future;
import collector.common.util.NorthwindException;
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
	 * Read timeout in milliseconds
	 */
	public static inline final READ_TIMEOUT = 1000;

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
	public function sendRequestWithResponse(request:ModbusRtuRequest):Future<ModbusRtuResponse> {
		var chan = cast(channel, IBinaryChannel);

		// Send data to device
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
		var network:Null<Int> = null;
		var fullSize = 0;
		var functionId:Null<Int> = null;
		var lengthRead = false;
		var answerLength = -1;

		var completer = new CompletionFuture<ModbusRtuResponse>();
		var packCompleter = new CompletionFuture<Bool>();

		// Read from channel
		chan.onData.timeout(TimeSpan.fromMSeconds(READ_TIMEOUT)).listen((data)
			-> {
				if (data.length < 1)
					return;

				fullSize += data.length;
				binary.addBytes(data);
				if (!lengthRead && fullSize > HEADER_SIZE) {
					network = binary.getByte(0);
					functionId = binary.getByte(1);

					if (functionId != null) {
						if (request.knownLength > 0) {
							answerLength = request.knownLength;
						} else {
							answerLength = getAnswerLength(functionId, binary);
						}
					}

					lengthRead = true;
				}

				if (answerLength < 1)
					return;

				if (fullSize - MIN_PACKET_SIZE > answerLength) {
					packCompleter.complete(true);
				}
			},
			(ex)
			-> {
				if ((ex is TimeoutException)) {
					if (binary.length < 1) {
						completer.throwError(new NorthwindException("Device not responds"));
					} else {
						packCompleter.complete(true);
					}
				}
			});

		packCompleter.onSuccess((_)
			-> {
				if (binary.length < MIN_PACKET_SIZE)
					throw new NorthwindException("Bad response");

				if (network == null || functionId == null)
					throw new NorthwindException("Bad response");

				var crcPos = binary.length - 2;
				var crcData = binary.slice(0, crcPos);
				var crc = binary.getInt16(crcPos);
				var calcCrc = ModbusRtuCrcHelper.calcCrc(crcData);
				if (crc != calcCrc)
					throw new NorthwindException("Wrong CRC");

				var respData = binary.slice(2, binary.length - MIN_PACKET_SIZE);
				completer.complete(new ModbusRtuResponse(network, functionId, respData));
			}).onError((ex) -> {
			completer.throwError(ex);
		});

		return completer;
	}
}

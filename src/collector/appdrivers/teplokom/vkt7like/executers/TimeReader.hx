package collector.appdrivers.teplokom.vkt7like.executers;

import core.async.future.Future;
import core.io.BinaryData;
import collector.common.util.NorthwindException;
import core.time.DateTime;
import collector.common.appdriver.CollectorDriverExecuter;
import collector.protocols.modbus.rtu.requests.ReadHoldingRegistersRequest;
import collector.appdrivers.teplokom.vkt7like.common.VktStartAddress;
import collector.appdrivers.teplokom.vkt7like.common.VktExecuterContext;

/**
 * Read time
 */
class TimeReader extends CollectorDriverExecuter<VktExecuterContext, DateTime> {
	/**
	 * 2000 constant
	 */
	public static inline final TWO_THOUSAND = 2000;

	/**
	 * Constructor
	 */
	public function new(executionContext:VktExecuterContext) {
		super(executionContext);
	}

	/**
	 * Execute one iteration and get result
	 * @param call
	 * @return -> Void)
	 */
	public override function executeOne():Future<DateTime> {
		var network = executionContext.model.networkAddress;
		var request = new ReadHoldingRegistersRequest(network, VktStartAddress.TIME_ADDRESS, 0);
		var completer = new CompletionFuture<DateTime>();
		executionContext.modbusProtocol.sendRequestWithResponse(request).onSuccess((response)
			-> {
				if (response.networkAddress != network)
					throw new NorthwindException("Request network address not equals response network address");

				var binary = BinaryData.ofBytes(response.data);
				var day = binary.getByte(1);
				var month = binary.getByte(2);
				var yearByte = binary.getByte(3);
				var hour = binary.getByte(4);
				var minute = binary.getByte(5);
				var second = binary.getByte(6);
				var year = TWO_THOUSAND + yearByte;
				completer.complete(new DateTime(year, month, day, hour, minute, second));
			});
		return completer;
	}
}

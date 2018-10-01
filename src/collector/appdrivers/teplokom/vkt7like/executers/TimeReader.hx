package collector.appdrivers.teplokom.vkt7like.executers;

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
	public override function executeOne():DateTime {
		var network = executionContext.model.networkAddress;
		var request = new ReadHoldingRegistersRequest(network, VktStartAddress.TIME_ADDRESS, 0);
		var response = executionContext.modbusProtocol.sendRequestWithResponse(request);
		if (response.networkAddress != network)
			throw new NorthwindException("Request network address not equals response network address");

		
		return DateTime.now();
	}
}

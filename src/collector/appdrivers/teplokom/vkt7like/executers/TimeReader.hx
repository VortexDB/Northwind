package collector.appdrivers.teplokom.vkt7like.executers;

import core.time.DateTime;
import collector.common.appdriver.CollectorDriverExecuter;
import collector.protocols.modbus.rtu.requests.ReadHoldingRegistersRequest;
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
		var request = new ReadHoldingRegistersRequest()
		var response = executionContext.modbusProtocol.sendRequestWithResponse();
		return DateTime.now();
	}
}

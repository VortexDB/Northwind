package collector.appdrivers.teplokom.vkt7like.executers;

import core.async.stream.StreamController;
import core.async.stream.Stream;
import collector.common.parameters.MeasureParameter;
import collector.appdrivers.teplokom.vkt7like.common.VktStartAddress;
import collector.protocols.modbus.rtu.requests.ReadHoldingRegistersRequest;
import collector.appdrivers.teplokom.vkt7like.common.VktExecuterContext;
import collector.common.appdriver.CollectorDriverExecuter;

/**
 * Current value
 */
class CurrentValue {
    /**
     * Constructor
     */
    public function new() {

    }
}

/**
 * Read current value from device
 */
class ValueReader extends CollectorDriverExecuter<VktExecuterContext, CurrentValue> {
    /**
     * Measure parameters to collect
     */
    private final parameters = new Array<MeasureParameter>();

	/**
	 * Call a call function on each iteration
	 * @param call
	 * @return -> Void)
	 */
	public override function execute():Stream<CurrentValue> {
        var controller = new StreamController<CurrentValue>();
        var network = executionContext.model.networkAddress;
		var request = new ReadHoldingRegistersRequest(network, VktStartAddress.TIME_ADDRESS, 0);
        executionContext.modbusProtocol.sendRequestWithResponse(request).onSuccess((response) -> {
            controller.add(new CurrentValue());
        });
		return controller.stream;
	}

    /**
     * Add measure parameter to collect
     * @param parameter 
     */
    public function addParameter(parameter:MeasureParameter) {
        parameters.push(parameter);
    }
}

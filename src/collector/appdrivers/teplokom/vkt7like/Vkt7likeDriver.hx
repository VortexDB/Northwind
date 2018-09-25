package collector.appdrivers.teplokom.vkt7like;

import collector.common.task.CollectorActionTask;
import collector.common.appdriver.CollectorMeterDriver;
import collector.protocols.modbus.rtu.ModbusRtuProtocol;

/**
 * Driver for Vkt7 like driver
 */
@:keep
class Vkt7likeDriver extends CollectorMeterDriver {
    /**
     * Constructor
     */
    public function new() {
        super(["Vkt7"], new ModbusRtuProtocol());
    }

    /**
	 * Process execute actions. Virtual
	 * @param action
	 */
	public override function executeActions(action:Array<CollectorActionTask>):Void {
        trace("EXECUTE ACTIONS");
    }
}
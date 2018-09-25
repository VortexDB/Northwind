package collector.appdrivers.teplokom.vkt7like;

import collector.common.task.CollectorActionTask;
import collector.common.appdriver.CollectorMeterDriver;
import collector.protocols.modbus.rtu.ModbusRtuProtocol;
import collector.common.parameters.DeviceAction;
import collector.appdrivers.teplokom.vkt7like.executers.TimeReader;

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
	public override function executeActions(actions:Array<CollectorActionTask>):Void {
        for (taskAction in actions) {
            switch (taskAction.action.actionType) {
                case ActionType.ReadDateTime:
                    // var reader = new TimeReader(executionContext);
                    // reader.execute();
                default:                
            }
        }
    }
}
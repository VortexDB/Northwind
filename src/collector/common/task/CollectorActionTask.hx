package collector.common.task;

import collector.common.parameters.DeviceAction;
/**
 * Task for execution actions on device
 */
class CollectorActionTask extends CollectorTask {
    /**
     * Action on device
     */
    public final action : DeviceAction;

    /**
     * Constructor
     */
    public function new(action:DeviceAction) {
        super();
        this.action = action;
    }
}
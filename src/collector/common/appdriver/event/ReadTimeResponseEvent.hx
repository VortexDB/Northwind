package collector.common.appdriver.event;

import core.time.DateTime;

/**
 * Response on time read
 */
class ReadTimeResponseEvent extends SingleValueResponseEvent<DateTime> {
    /**
     * Constructor
     * @param taskId 
     * @param value 
     */
    public function new(taskId:Int, value:DateTime) {
        super(taskId, value);
    }
}
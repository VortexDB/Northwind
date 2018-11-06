package collector.common.appdriver.event;

/**
 * Event about data from device
 */
class TaskDataResponseEvent extends DriverTaskEvent {
    /**
     * Constructor
     * @param taskId 
     */
    public function new(taskId:Int) {
        super(taskId);
    }
}
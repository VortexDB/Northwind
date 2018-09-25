package collector.common.appdriver.event;

/**
 * Event about data from device
 */
class TaskDataResponseEvent extends DriverTaskResponseEvent {
    /**
     * Constructor
     * @param taskId 
     */
    public function new(taskId:Int) {
        super(taskId);
    }
}
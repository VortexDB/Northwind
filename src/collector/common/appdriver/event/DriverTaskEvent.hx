package collector.common.appdriver.event;

/**
 * Event on collector task
 */
class DriverTaskEvent extends CollectorDriverEvent {
    /**
     * Collector task id
     */
    public final taskId:Int;

    /**
     * Constructor
     * @param taskId 
     */
    public function new(taskId:Int) {
        this.taskId = taskId;
    }
}
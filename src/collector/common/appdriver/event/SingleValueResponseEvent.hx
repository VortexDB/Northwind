package collector.common.appdriver.event;

/**
 * Response with single value
 */
class SingleValueResponseEvent<T> extends TaskDataResponseEvent {
    /**
     * Some value
     */
    public final value:T;

    /**
     * Constructor
     * @param value 
     */
    public function new(taskId:Int, value:T) {
        this.value = value;
        super(taskId);
    }
}
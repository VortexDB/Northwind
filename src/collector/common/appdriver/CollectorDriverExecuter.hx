package collector.common.appdriver;

/**
 * Executer that works in the context of driver
 */
class CollectorDriverExecuter<T> {
    /**
     * Execution context, that transfered from driver
     */
    public final executionContext : ExecutionContext;

    /**
     * Constructor
     */
    public function new(executionContext : ExecutionContext) {
        this.executionContext = executionContext;
    }
}
package collector.common.appdriver;

import collector.common.appdriver.ExecutionContext;
/**
 * Executer that works in the context of driver
 */
class CollectorDriverExecuter<TContext:ExecutionContext, TResult> {
    /**
     * Execution context, that transfered from driver
     */
    public final executionContext : TContext;

    /**
     * Constructor
     */
    public function new(executionContext : TContext) {
        this.executionContext = executionContext;
    }

    /**
     * Call a call function on each iteration
     * @param call 
     * @return -> Void)
     */
    public function execute(call:(TResult) -> Void): Void { throw "Not implemented"; }

    /**
     * 
     * @param call 
     * @return -> Void)
     */
    public function executeOne(): TResult { throw "Not implemented"; }
}
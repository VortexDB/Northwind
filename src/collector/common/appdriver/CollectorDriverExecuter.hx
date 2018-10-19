package collector.common.appdriver;

import core.async.future.Future;
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
    public function execute(call:(TResult) -> Void): Future<Void> { throw "Not implemented"; }

    /**
     * Execute one iteration and get result
     * @param call 
     * @return -> Void)
     */
    public function executeOne(): Future<TResult> { throw "Not implemented"; }
}
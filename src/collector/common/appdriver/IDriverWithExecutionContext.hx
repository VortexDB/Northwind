package collector.common.appdriver;

import collector.common.appdriver.ExecutionContext;

/**
 * Interface for driver that uses executers
 */
interface IDriverWithExecutionContext<T:ExecutionContext> {
	/**
	 * Execution context
	 */
	var executionContext:T;
}

package collector.appdrivers.teplokom.vkt7like.executers;

import collector.common.appdriver.ExecutionContext;
import core.time.DateTime;
import collector.common.appdriver.CollectorDriverExecuter;

/**
 * Read time
 */
class TimeReader extends CollectorDriverExecuter<DateTime> {
    /**
     * Constructor
     */
    public function new(executionContext:ExecutionContext) {
        super(executionContext);
    }
}
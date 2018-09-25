package collector.appdrivers.teplokom.vkt7like.executers;

import collector.common.appdriver.ExecutionContext;
import core.time.DateTime;
import collector.common.appdriver.CollectorDriverExecuter;
import collector.appdrivers.teplokom.vkt7like.common.VktExecuterContext;

/**
 * Read time
 */
class TimeReader extends CollectorDriverExecuter<VktExecuterContext, DateTime> {
    /**
     * Constructor
     */
    public function new(executionContext:VktExecuterContext) {
        super(executionContext);
    }
}
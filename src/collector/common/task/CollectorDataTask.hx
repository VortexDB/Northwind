package collector.common.task;

import collector.common.parameters.MeasureParameter;
import collector.common.parameters.DateInterval;

/**
 * Task to collect some measure data
 */
class CollectorDataTask extends CollectorTask {
    /**
     * Interval of reading
     */
    public final interval : DateInterval;

    /**
     * Measure parameter to read
     */
    public final parameter : MeasureParameter;

    /**
     * Constructor
     * @param parameter 
     * @param interval 
     */
    public function new(parameter:MeasureParameter, interval:DateInterval) {
      super();
      this.interval = interval;
      this.parameter = parameter;
    }
}
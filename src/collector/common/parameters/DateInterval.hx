package collector.common.parameters;

import core.time.DateTime;

/**
 * Interval with start and end dates
 */
class DateInterval {
    /**
     * Start date
     */
    public final startDate : DateTime;
    
    /**
     * End date
     */
    public final endDate : DateTime;
    
    /**
     * Constructor
     * @param @startDate 
     * @param @endDate 
     */
    public function new(startDate:DateTime, endDate:DateTime) {
        this.startDate = startDate;
        this.endDate = endDate;
    }
}
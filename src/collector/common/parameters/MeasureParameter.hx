package collector.common.parameters;

/**
 * Parameter for collect data
 */
class MeasureParameter {
	/**
	 * Measure type
	 */
	public final measureType:MeasureType;

	/**
	 * Discret of parameter
	 */
	public final discret:Discret;

	/**
	 * Constructor
	 */
	public function new(measureType:MeasureType, discret:Discret) {
		this.measureType = measureType;
		this.discret = discret;
	}
}

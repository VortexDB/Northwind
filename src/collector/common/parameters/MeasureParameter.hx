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

	/**
	 * Calc hash
	 * @return Int
	 */
	public function hashCode():Int {
		return measureType.hashCode() ^ discret.hashCode();
	}

	/**
	 * Compare objects
	 * @param other
	 * @return Bool
	 */
	public function equals(other:Dynamic):Bool {
		if (Std.is(other, MeasureParameter)) {
			return hashCode() == cast(other, MeasureParameter).hashCode();
		}

		return false;
	}
}

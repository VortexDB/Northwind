package collector.common.parameters;

using core.utils.StringHelper;

/**
 * Basic measure type like energy, pressure, temperatur
 */
enum BaseMeasureType {
	Energy; 
	Power; 
	Current; 
	Voltage; 
	Temperature; 
	Pressure; 
	Flow;
}

/**
 * Measure type
 */
class MeasureType {
	/**
	 * Name of measure. Must be unique
	 */
	public final name:String;

	/**
	 * Basic measure type
	 */
	public final baseMeasure:BaseMeasureType;

	/**
	 * Constructor
	 * @param name
	 * @param baseMeasure
	 */
	public function new(name:String, baseMeasure:BaseMeasureType) {
		this.name = name;
		this.baseMeasure = baseMeasure;
	}

	/**
	 * Calc hash
	 * @return Int
	 */
	public function hashCode():Int {
		return name.hashCode();
	}

	/**
	 * Compare objects
	 * @param other
	 * @return Bool
	 */
	public function equals(other:Dynamic):Bool {
		if (Std.is(other, MeasureType)) {
			return name == cast(other, MeasureType).name;
		}

		return false;
	}
}

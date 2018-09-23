package collector.common.parameters;

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
}

package collector.database;

/**
 * Database device entity
 */
class DbDevice extends DbEntity {
	/**
	 * Device model type
	 */
	public var modelType:String;

	/**
	 * Protocol type
	 */
	public var protocolType:String;

	/**
	 * Serial number
	 */
	public var serial:String;

	/**
	 * Network address
	 */
	public var network:Int;

	/**
	 * Routes of device
	 */
	public var routes:Array<Int>;

	/**
	 * Convert to string
	 * @return String
	 */
	public override function toString():String {
		return super.toString() + ' Model: ${modelType} Protocol: ${protocolType} Serial: ${serial} Network: ${network}';
	}
}

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
	 * Convert to string
	 * @return String
	 */
	public override function toString():String {
		return super.toString() + ' ModelType: ${modelType} ProtocolType: ${protocolType}';
	}
}
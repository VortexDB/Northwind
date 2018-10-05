package collector.database;

/**
 * Database device serial route
 */
class DbSerialRoute extends DbEntity {
    /**
     * Name of serial port
     */
    public var port:String;

    /**
     * Speed of port
     */
    public var speed:Int;

    /**
     * Byte type: 8N1, 7E2
     */
    public var byteType:String;

    /**
	 * Convert to string
	 * @return String
	 */
	public override function toString():String {
		return super.toString() + ' Port: ${port} Speed: ${speed} ByteType: ${byteType}';
	}
}
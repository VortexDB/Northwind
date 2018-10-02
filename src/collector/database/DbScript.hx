package collector.database;

/**
 * Database script entity
 */
class DbScript {
    /**
     * Name of script
     */
    public var name:String;

    /**
     * Deep of collecting data in days
     */
    public var deep:Int;

    /**
     * Parameters to collect data
     */
    public var parameters:Array<DbMeasureParameter>;

    /**
     * Actions to work on device
     */
    public var actions:Array<DbDeviceAction>;
}
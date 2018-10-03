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
     * Ids of Parameters to collect data
     */
    public var parameters:Array<Int>;

    /**
     * Ids of Actions to work on device
     */
    public var actions:Array<Int>;
}
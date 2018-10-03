package collector.database;

/**
 * Database measure parameter
 */
class DbMeasureParameter extends DbEntity {
    /**
     * Name of parameter
     */
    public var name:String;

    /**
     * Discret type: Day: Month, etc
     */
    public var discretType:Int;

    /**
     * Discret value
     */
    public var discretValue:Int;
}
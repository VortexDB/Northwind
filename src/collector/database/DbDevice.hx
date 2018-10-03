package collector.database;

/**
 * Database device entity
 */
@:keep
class DbDevice extends DbEntity {
    /**
     * Device model type
     */
    public var modelType:String;    

    /**
     * Protocol type
     */
    public var protocolType:String;
}
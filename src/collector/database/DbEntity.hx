package collector.database;

/**
 * Database entity
 */
class DbEntity {
    /**
     * Entity id
     */
    public var id:Int;

    /**
     * Custom attribute values
     */
    public var attributes:Map<String, String>;

    /**
     * Constructor
     */
    public function new() {
        attributes = new Map<String, String>();
    }
}
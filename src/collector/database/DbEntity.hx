package collector.database;

/**
 * Database entity
 */
@:keep
@:rtti
class DbEntity {
    /**
     * Entity id
     */
    @jsonIgnore
    public var id:Int;

    /**
     * Entity type to split it from other entities
     */
    @jsonIgnore
    public var entityType:String;

    /**
     * Constructor
     */
    public function new() {}

    /**
     * Convert to string
     * @return String
     */
    /*public function toString():String {
        return 'Id: ${id} EntityType: ${entityType}';
    }*/
}
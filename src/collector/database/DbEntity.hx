package collector.database;

/**
 * Database entity
 */
class DbEntity {
    /**
     * Entity id
     */
    public final id:Int;

    /**
     * Entity type to split it from other entities
     */
    public final entityType:String;

    /**
     * Custom attribute values
     */
    public var attributes:Map<String, String>;

    /**
     * Constructor
     */
    public function new(id:Int) {
        attributes = new Map<String, String>();
        entityType = Type.getClassName(Type.getClass(this));   
        this.id = id;
    }
}
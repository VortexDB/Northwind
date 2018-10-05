package collector.database;

/**
 * Database entity
 */
@:keepSub
class DbEntity {
	/**
	 * Entity id
	 */
	public var id:Int;

	/**
	 * Entity type to split it from other entities
	 */
	public var entityType:String;

	/**
	 * Constructor
	 */
	private function new() {}

	/**
	 * Convert to string
	 * @return String
	 */
	public function toString():String {
		return 'Id: ${id} EntityType: ${entityType}';
	}
}

package collector.database;

import haxe.Log;
import sys.FileSystem;
import haxe.io.Bytes;
import haxe.crypto.Base64;
import sys.db.Sqlite;
import sys.db.Connection;

/**
 * For storing data
 */
class Database {
	/**
	 * Delimiter for attributes in content column
	 */
	public static inline final ATTRIBUTE_DELIMITER = "|";

	/**
	 * Delimiter between attribute name and value
	 */
	public static inline final VALUE_DELIMITER = "::";

	/**
	 * Interface to connect to database
	 */
	private var connection:Connection;

	/**
	 * Current entity id
	 */
	private var currentId = 0;

	/**
	 * Instance of database
	 */
	public static final instance:Database = new Database();

	/**
	 * Create database structure
	 */
	private function createDatabase(connection:Connection) {
		Log.trace("Creating database");
		connection.request("CREATE TABLE entities(
            id integer PRIMARY KEY,
            entityType TEXT NOT NULL,
            content TEXT)");
	}

	/**
	 * Open database
	 */
	public function open() {
		if (connection != null)
			return;

		var needCreate = !FileSystem.exists("northwind.db");
		connection = Sqlite.open("northwind.db");

		if (needCreate)
			createDatabase(connection);
	}

	/**
	 * Create entity of type and from content
	 * Content:
	 * Where | - ATTRIBUTE_DELIMITER
	 */
	private function decodeEntity<T:DbEntity>(type:Class<T>, id:Int, content:String):T {
		//var entity = serializer.unserialize(Bytes.ofString(content), type);
		// entity.id = id;

		return null;
	}

	/**
	 * Encode entity to content string for storing in database
	 * @param entity
	 */
	private function encodeEntity(entity:DbEntity):String {
		return null;
	}

	/**
	 * Return next id of entity
	 */
	private function getNextId():Int {
		currentId += 1;
		return currentId;
	}

	/**
	 * Private constructor
	 */
	private function new() {
		// TODO: remove. hxbit bug
	}

	/**
	 * Create new entity
	 */
	public function createEntity<T:DbEntity>(type:Class<T>):T {
		var instance:T = cast Type.createEmptyInstance(type);
		instance.id = getNextId();
		instance.entityType = Type.getClassName(type);
		return instance;
	}

	/**
	 * Save entity to database
	 */
	public function saveEntity<T:DbEntity>(entity:T) {
		var content = encodeEntity(entity);

		connection.request
			('INSERT INTO entities (id, entityType, content)
		VALUES(${entity.id}, \'${entity.entityType}\', \'${content}\')
		ON CONFLICT(id)
		DO UPDATE SET content=\'${content}\';');
	}

	/**
	 * Get entity by id and type
	 * @param type
	 * @return Array<T>
	 */
	public function getEntity<T:DbEntity>(id:Int, type:Class<T>):T {
		var typeName = Type.getClassName(type);
		var resp = connection.request('select id, content from entities where id=${id} and entityType=\'${typeName}\'');
		if (!resp.hasNext())
			return null;

		var data = resp.next();
		var id = data.id;
		var content = data.content;
		var ints = decodeEntity(type, id, content);
		return ints;
	}

	/**
	 * Get all entity by type
	 * @param type
	 */
	public function getEntities<T:DbEntity>(type:Class<T>):Array<T> {
		var typeName = Type.getClassName(type);
		var resp = connection.request('select id, content from entities where entityType=\'${typeName}\'');
		if (!resp.hasNext())
			return null;

		var res = new Array<T>();
		for (data in resp) {
			var id = data.id;
			var content = data.content;
			res.push(decodeEntity(type, id, content));
		}

		return res;
	}
}

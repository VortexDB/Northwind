package collector.database;

import haxe.Serializer;
import haxe.Unserializer;
import haxe.Log;
import haxe.io.Bytes;
import haxe.crypto.Base64;
import sys.db.Sqlite;
import sys.db.Connection;
import sys.FileSystem;

/**
 * For storing data
 */
class Database {
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
		var resp = connection.request("select count(*) as itemcount from  entities");
		var data = resp.next();
		currentId = data.itemcount;
		
		if (needCreate)
			createDatabase(connection);
	}

	/**
	 * Create entity of type and from content
	 * Content:
	 * Where | - ATTRIBUTE_DELIMITER
	 */
	private function decodeEntity(id:Int, content:String):Dynamic {
		return Unserializer.run(content);
	}

	/**
	 * Encode entity to content string for storing in database
	 * @param entity
	 */
	private function encodeEntity(entity:DbEntity):String {
		return Serializer.run(entity);
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
	private function new() {}

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
	 * Get entity by id
	 * @param type
	 * @return Array<T>
	 */
	public function getById(id:Int):Dynamic {
		var resp = connection.request('select id, content from entities where id=${id}');

		var data = resp.next();
		if (data == null)
			return null;

		var id = data.id;
		var content = data.content;
		var ints = decodeEntity(id, content);
		return ints;
	}

	/**
	 * Get entities by id
	 * @param type
	 * @return Array<T>
	 */
	public function getByIds(ids:Array<Int>):Dynamic {
		if (ids.length < 1)
			return null;

		var arr = new Array<Dynamic>();
		for (id in ids) {
			var it = getById(id);
			if (it != null)
				arr.push(it);
		}

		return arr;
	}

	/**
	 * Get all entities by type
	 * @param type
	 */
	public function getByType<T:DbEntity>(type:Class<T>):Array<T> {
		var typeName = Type.getClassName(type);
		var resp = connection.request('select id, content from entities where entityType=\'${typeName}\'');

		var res = new Array<T>();
		for (data in resp) {
			var id = data.id;
			var content = data.content;
			var it = cast decodeEntity(id, content);
			if (it != null)
				res.push(it);
		}

		return res;
	}	
}

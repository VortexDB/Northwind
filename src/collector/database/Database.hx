package collector.database;

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
	public static inline final VALUE_DELIMITER = "=";

	/**
	 * Interface to connect to database
	 */
	private var connection:Connection;

	/**
	 * Instance of database
	 */
	public static final instance:Database = new Database();	

	/**
	 * Create database structure
	 */
	private function createDatabase(connection:Connection) {
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

		var needCreate = FileSystem.exists("northwind.db");
		connection = Sqlite.open("northwind.db");

		if (needCreate)
			createDatabase(connection);
	}

	/**
	 * Create entity of type and from content
	 * Content:
	 * AttributeName1=AttributeValue1(Base64)|AttributeName2=AttributeValue2(Base64)
	 * Where | - ATTRIBUTE_DELIMITER
	 */
	private function decodeEntity<T:DbEntity>(type:Class<T>, id:Int, content:String):T {
		var inst:T = cast Type.createInstance(type, [id]);
		if (inst == null)
			return null;

		var items = content.split(ATTRIBUTE_DELIMITER);
		for (item in items) {
			var nameValue = item.split(VALUE_DELIMITER);
			if (nameValue.length != 2)
				continue;

			var name = nameValue[0];
			var value = Base64.decode(nameValue[1]).toString();
			inst.attributes[name] = value;
		}
		return inst;
	}

	/**
	 * Encode entity to content string for storing in database
	 * @param entity
	 */
	private function encodeEntity(entity:DbEntity):String {
		var buffer = new StringBuf();
		for (key in entity.attributes.keys()) {
			var value = entity.attributes[key];
			var base64Value = Base64.encode(Bytes.ofString(value));
			buffer.add('${key}${VALUE_DELIMITER}${base64Value}');
		}
		return buffer.toString();
	}

	/**
	 * Private constructor
	 */
	private function new() {
	}

	/**
	 * Get entity by id and type
	 * @param type
	 * @return Array<T>
	 */
	public function getEntity<T:DbEntity>(id:Int, type:Class<T>):T {
		var typeName = Type.getClassName(type);
		var resp = connection.request('select id, content from entities where id=${id} and entityType=${typeName}');
		if (resp.length < 1)
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
		var resp = connection.request('select id, content from entities where entityType=${typeName}');
		if (resp.length < 1)
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

package collector.database;

import sys.db.Sqlite;
import sys.db.Connection;

/**
 * For storing data
 */
class Database {
	/**
	 * Interface to connect to database
	 */
	private var connection:Connection;

	/**
	 * Open database
	 */
	public static function open():Database {
        var database = new Database();
        database.connection = Sqlite.open("northwind.db");
        return database;
	}

	/**
	 * Private constructor
	 */
	private function new() {}

	/**
	 * Get entity by id and type
	 * @param type
	 * @return Array<T>
	 */
	public function getEntity<T>(id:Int, type:Class<T>):T {
        var typeName = Type.getClassName(type);
        var resp = connection.request('select id, content from entities where id=${id} and entityType=${typeName}')
        if (resp.length < 1)        
		    return null;

        var data = resp.next();
        var id = data.id;
        var content = data.content;
        var ints = Type.createInstance(type, [id]);
        return ints;
	}

	/**
	 * Get all entity by type
	 * @param type
	 */
	public function getEntities<T>(type:Class<T>):Array<T> {
		return null;
	}
}

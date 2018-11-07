package webadmin.model;

import coconut.data.Model;

/**
 * Main model of all app
 */
class AppModel implements Model {
    /**
     * Title of app
     */
    @:constant public var title:String = "Northwind web";
}
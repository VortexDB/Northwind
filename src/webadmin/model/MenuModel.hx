package webadmin.model;

import coconut.data.Model;

/**
 * Menu item model
 */
class MenuItemModel implements Model {
    /**
     * Id of item
     */
    @:constant public var id:String;

    /**
     * Title of item
     */
    @:constant public var title:String;
}

/**
 * Menu model
 */
class MenuModel implements Model {
    /**
     * Menu items
     */
    @:constant public var items:tink.pure.List<MenuItemModel>;
}
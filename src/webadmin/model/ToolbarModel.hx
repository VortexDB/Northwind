package webadmin.model;

import coconut.data.Model;

/**
 * Toolbar model item
 */
class ToolbarItemModel implements Model {
    /**
     * Icon of item
     */
    @:constant public var icon:String;
}

/**
 * Model for toolbar
 */
class ToolbarModel implements Model {
    /**
     * Items
     */
    @:constant public var items:tink.pure.List<ToolbarItemModel>;
}
package webadmin.model;

import coconut.data.Model;
import webadmin.model.MenuModel;
import webadmin.model.MenuModel.MenuItemModel;
import webadmin.view.pages.DevicesPage;
import webadmin.view.pages.RoutesPage;

/**
 * Main model of all app
 */
class AppModel implements Model {
    /**
     * Title of app
     */
    @:constant public var title:String = "Northwind admin";

    /**
     * Current page id for displaying in content
     */
    @:editable public var currentPageId:String = DevicesPage.ID;

    /**
     * Menu model
     */
    @:constant public var menuModel:MenuModel = new MenuModel({
        items: [
            new MenuItemModel({ id:DevicesPage.ID, title: "Devices" }),
            new MenuItemModel({ id:RoutesPage.ID, title: "Routes" }),
            new MenuItemModel({ id:"Scripts", title: "Scripts" }),
            new MenuItemModel({ id:"Diagnostics", title: "Diagnostics" })
        ]
    });
}
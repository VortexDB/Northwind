package webadmin.model;

import coconut.data.Model;
import webadmin.model.MenuModel;
import webadmin.model.MenuModel.MenuItemModel;
import webadmin.view.pages.DevicesPage;
import webadmin.view.pages.RoutesPage;
import webadmin.view.pages.ScriptsPage;
import webadmin.view.pages.DiagnosticsPage;

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
            new MenuItemModel({ id:DevicesPage.ID, icon:"assets/images/mobile-devices.svg", title: "Devices" }),
            new MenuItemModel({ id:RoutesPage.ID, icon:"assets/images/device_hub.svg", title: "Routes" }),
            new MenuItemModel({ id:ScriptsPage.ID, icon:"assets/images/harvest.svg", title: "Scripts" }),
            new MenuItemModel({ id:DiagnosticsPage.ID, icon:"assets/images/bar-chart.svg", title: "Diagnostics" })
        ]
    });
}
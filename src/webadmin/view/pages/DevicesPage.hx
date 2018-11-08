package webadmin.view.pages;

import coconut.ui.View;
import coconut.Ui.hxx;
import webadmin.model.DataGridModel;
import webadmin.view.controls.DataGrid;

/**
 * Page for devices
 */
class DevicesPage extends View {
    /**
     * Id of devices page
     */
    public static inline final ID = "Devices";

    /**
	 * Render component
	 */
    function render() {
        var devices = new DataGridModel();
        //devices.addColumn(new GridColumnModel({ title: "Id", index: 1 }));

        return hxx('
        <div>
            <DataGrid model=${devices} />
        </div>
        ');
    }
}
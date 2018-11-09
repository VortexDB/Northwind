package webadmin.view.pages;

import coconut.ui.View;
import coconut.Ui.hxx;
import webadmin.model.DataGridModel;
import webadmin.model.DataGridModel.GridColumnModel;
import webadmin.model.DataGridModel.GridRowModel;
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
		var devices = new DataGridModel({
            columns: [
                new GridColumnModel({ index: 1, title: "#" }),
                new GridColumnModel({ index: 2, title: "Caption" }),
                new GridColumnModel({ index: 3, title: "Device" }),
                new GridColumnModel({ index: 4, title: "Protocol" }),
                new GridColumnModel({ index: 5, title: "Serial" })
            ],
            rows: [
                new GridRowModel(),
                new GridRowModel()
            ]
        });
		// devices.addColumn(new GridColumnModel({ title: "Id", index: 1 }));

		return hxx('
            <div class="page">
                <DataGrid model=${devices} />
            </div>
        ');
	}
}

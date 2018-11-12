package webadmin.view.pages;

import coconut.ui.View;
import coconut.Ui.hxx;
import webadmin.model.DataGridModel;
import webadmin.model.DataGridModel.GridColumnModel;
import webadmin.model.DataGridModel.GridRowModel;
import webadmin.model.ToolbarModel;
import webadmin.view.controls.Toolbar;
import webadmin.view.controls.DataGrid;

class DeviceModelAdapter implements IDataGridModelAdapter {
	/**
	 * Constructor
	 */
	public function new() {}

	/**
	 * Return columns
	 */
	public function getColumns():tink.pure.List<GridColumnModel> {
		return [
			new GridColumnModel({index: 1, title: "#"}),
			new GridColumnModel({index: 2, title: "Caption"}),
			new GridColumnModel({index: 3, title: "Device"}),
			new GridColumnModel({index: 4, title: "Protocol"}),
			new GridColumnModel({index: 5, title: "Serial"})
		];
	}

	/**
	 * Return rows
	 */
	public function getRows():tink.pure.List<GridRowModel> {
		return [
			new GridRowModel({
				values: ["1", "My device", "Vkt7", "Modbus RTU", "32123123"]
			}),
			new GridRowModel({
				values: ["2", "Device", "Vkt7", "Modbus RTU", "14587321"]
			})
		];
	}

	/**
	 * Return value as formatted string for row by column index
	 * @param index
	 */
	public function getValue(values:tink.pure.List<Dynamic>, index:Int):String {
		return values.toArray()[index - 1];
	}
}

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
			adapter: new DeviceModelAdapter()
		});

        var toolbar = new ToolbarModel({
            items: [
                new ToolbarItemModel({ icon: "New" }),
                new ToolbarItemModel({ icon: "Edit" }),
                new ToolbarItemModel({ icon: "Delete" })
            ]
        });

		// devices.addColumn(new GridColumnModel({ title: "Id", index: 1 }));

		return hxx('
            <div class="page">
                <Toolbar model=${toolbar} />
                <DataGrid model=${devices} />
            </div>
        ');
	}
}

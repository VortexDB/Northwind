package webadmin.view.controls;

import coconut.ui.View;
import coconut.Ui.hxx;
import webadmin.model.DataGridModel;

/**
 * Grid with columns and rows for data
 */
class DataGrid extends View {
    /**
     * Data grid model
     */
    @:attribute public var model:DataGridModel;

    /**
	 * Render component
	 */
    function render() {
        return hxx('
            <div class="data-grid">
                <table class="table">
                    <thead>
                        <tr>
                            <for {col in model.columns}>
                                <th>{col.title}</th>
                            </for>
                        </tr>
                    </thead>
                    <tbody>
                        <for {row in model.rows}>
                            <tr class="grid-row">
                                <for {col in model.columns}>
                                    <td>{model.adapter.getValue(row.values, col.index)}</td>
                                </for>
                            </tr>
                        </for>                        
                    </tbody>
                </table>
            </div>
        ');
    }
}
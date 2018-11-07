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
                <table>
                    <thead>
                        <for {col in model.columns}>
                            {col.title}
                        </for>
                    </thead>
                    <tbody>
                        <for {row in model.rows}>
                            <for {col in model.columns}>
                                <tr>
                                    <td>{row.getValue(col.index)}</td>
                                </tr>
                            </for>
                        </for>                        
                    </tbody>
                </table>
            </div>
        ');
    }
}
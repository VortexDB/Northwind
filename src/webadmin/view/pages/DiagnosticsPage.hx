package webadmin.view.pages;

import coconut.ui.View;
import coconut.Ui.hxx;

/**
 * Page for routes
 */
class DiagnosticsPage extends View {
    /**
     * Id of devices page
     */
    public static inline final ID = "Diagnostics";

    /**
	 * Render component
	 */
    function render() {
        return hxx('
        <div>
            Diagnostics
        </div>
        ');
    }
}
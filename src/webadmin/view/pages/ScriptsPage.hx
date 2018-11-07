package webadmin.view.pages;

import coconut.ui.View;
import coconut.Ui.hxx;

/**
 * Page for routes
 */
class ScriptsPage extends View {
    /**
     * Id of devices page
     */
    public static inline final ID = "Scripts";

    /**
	 * Render component
	 */
    function render() {
        return hxx('
        <div>
            Scripts
        </div>
        ');
    }
}
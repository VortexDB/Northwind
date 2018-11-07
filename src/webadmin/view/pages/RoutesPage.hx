package webadmin.view.pages;

import coconut.ui.View;
import coconut.Ui.hxx;

/**
 * Page for routes
 */
class RoutesPage extends View {
    /**
     * Id of devices page
     */
    public static inline final ID = "Routes";

    /**
	 * Render component
	 */
    function render() {
        return hxx('
        <div>
            Routes
        </div>
        ');
    }
}
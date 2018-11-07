package webadmin.view.pages;

import coconut.ui.View;
import coconut.Ui.hxx;

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
        return hxx('
        <div>
            Devices
        </div>
        ');
    }
}
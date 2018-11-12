package webadmin.view.controls;

import coconut.ui.View;
import coconut.Ui.hxx;
import webadmin.model.ToolbarModel;

/**
 * Toolbar component
 */
class Toolbar extends View {
    /**
     * Model of toolbar
     */
    @:attribute public var model:ToolbarModel;

    /**
	 * Render component
	 */
    function render() {
        return hxx('
            <div class="toolbar">
                <for {item in model.items}>
                    <div class="item">
                        {item.icon}
                    </div>
                </for>
            </div>
        ');
    }
}
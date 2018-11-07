package webadmin.view;

import coconut.ui.View;
import coconut.Ui.hxx;

/**
 * Left menu panel
 */
class ContentPanel extends View {
	/**
	 * Render component
	 */
	function render() {
		return hxx('
            <div>Content panel</div>
        ');
	}
}
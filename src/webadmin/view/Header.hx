package webadmin.view;

import coconut.ui.View;
import coconut.Ui.hxx;

/**
 * Header
 */
class Header extends View {
	/**
	 * Title of header
	 */
	@:attribute public var title:String;

	/**
	 * Render component
	 */
	function render() {
		return hxx('
			<div class="header navbar navbar-expand-lg navbar-light bg-light">
				<div class="navbar-brand">${title}</div>
			</div>
		');
	}
}

package webadmin.view;

import coconut.ui.View;
import coconut.Ui.hxx;
import webadmin.view.Header;
import webadmin.view.MenuPanel;
import webadmin.view.ContentPanel;
import webadmin.model.AppModel;

/**
 * Main app
 */
class App extends View {
	/**
	 * Main model
	 */
	@:attribute public var model:AppModel;

	/**
	 * Render component
	 */
	function render() {
		return hxx('
			<div id="app">
				<Header title=${model.title} />
				<MenuPanel />
				<ContentPanel />
			</div>
		');
	}
}

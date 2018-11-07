package webadmin.view;

import webadmin.model.MenuModel.MenuItemModel;
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
	 * On menu item select
	 * @param item 
	 */
	private function onSelect(item:MenuItemModel) {
		if (model.currentPageId != item.id)
			model.currentPageId = item.id;
	}

	/**
	 * Render component
	 */
	function render() {
		return hxx('
			<div id="app">
				<Header title=${model.title} />
				<div id="main-panel">
					<MenuPanel model=${model.menuModel} onSelect={onSelect} />
					<ContentPanel pageId=${model.currentPageId} />
				</div>
			</div>
		');
	}
}

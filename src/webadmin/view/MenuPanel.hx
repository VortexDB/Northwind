package webadmin.view;

import coconut.ui.View;
import coconut.Ui.hxx;
import webadmin.model.MenuModel;

/**
 * Left menu panel
 */
class MenuPanel extends View {
	/**
	 * Model of menu
	 */
	@:attribute public var model:MenuModel;

	/**
	 * On item select callback
	 */
	@:attribute public var onSelect:(MenuItemModel)->Void;

	/**
	 * Render component
	 */
	function render() {
		return hxx('
            <div class="menu-panel">
				<for { item in model.items }>
					<div class="menu-item" onclick={onSelect(item)}>
						<img class="icon" src=${item.icon}></img>
						<div class="title">${item.title}</div>
					</div>
				</for>
			</div>
        ');
	}
}

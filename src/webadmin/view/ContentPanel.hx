package webadmin.view;

import coconut.ui.View;
import coconut.Ui.hxx;
import webadmin.view.pages.DevicesPage;
import webadmin.view.pages.RoutesPage;

/**
 * Left menu panel
 */
class ContentPanel extends View {
	/**
	 * Id of page
	 */
	@:attribute public var pageId:String;

	/**
	 * Render component
	 */
	function render() {
		return hxx('
            <div class="content-panel">
				<switch {pageId}>
					<case {DevicesPage.ID}>
						<DevicesPage />
					<case {RoutesPage.ID}>
						<RoutesPage />
				</switch>
			</div>
        ');
	}
}
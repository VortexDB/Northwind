package webadmin.view;

import coconut.ui.View;
import coconut.Ui.hxx;
import webadmin.view.pages.DevicesPage;
import webadmin.view.pages.RoutesPage;
import webadmin.view.pages.ScriptsPage;
import webadmin.view.pages.DiagnosticsPage;

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
					<case {ScriptsPage.ID}>
						<ScriptsPage />
					<case {DiagnosticsPage.ID}>
						<DiagnosticsPage />
				</switch>
			</div>
        ');
	}
}
package webadmin.view;

import react.ReactComponent;
import react.ReactMacro.jsx;
import webadmin.view.Header;
import webadmin.view.MenuPanel;


/**
 * Main app
 */
class App extends ReactComponent {
	/**
	 * Constructor
	 * @param props
	 */
	public function new() {
		super();
	}

	/**
	 * Render component
	 */
	override function render() {
		return jsx('
		<div>
			<div><$Header/></div>
			<div>
				<div>
					<$MenuPanel/>
				</div>
				<div>
					Content
				</div>
			</div>
		</div>
		');
	}
}

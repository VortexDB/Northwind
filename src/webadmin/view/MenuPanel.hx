package webadmin.view;

import react.React;
import react.ReactComponent;
import react.ReactMacro.jsx;

/**
 * Left menu panel
 */
class MenuPanel extends ReactComponent {
    /**
	 * Constructor
	 */
	public function new() {
		super();
	}

    /**
	 * Render component
	 */
	override function render() {
		return jsx
			('
            <div>Menu panel</div>
        ');
	}
}
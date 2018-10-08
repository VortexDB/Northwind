package webadmin.view;

import react.React;
import react.ReactComponent;
import react.ReactMacro.jsx;

/**
 * Header
 */
class Header extends ReactComponent {
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
            <nav className="navbar navbar-expand-lg navbar-light bg-light">
                <a className="navbar-brand" href="#">Northwind</a>
            </nav>
        ');
	}
}

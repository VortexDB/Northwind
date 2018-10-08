package webadmin;

import js.Browser;
import react.ReactDOM;
import react.ReactMacro.jsx;
import webadmin.view.App;


/**
 * Class with entry point
 */
class Main
{
	/**
	 * Entry point
	 */
	public static function main()
	{
		ReactDOM.render(jsx('<$App/>'), Browser.document.getElementById('app'));
	}
}

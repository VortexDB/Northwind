package webadmin;

import js.Browser.*;
import coconut.Ui.hxx;
import webadmin.view.App;
import webadmin.model.AppModel;


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
		var appModel = new AppModel();
		document.body.appendChild(hxx('<App model={appModel} />').toElement());
	}
}

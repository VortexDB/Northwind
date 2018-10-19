package collector;

import collector.common.route.DeviceRoute;
import collector.database.DbSerialRoute;
import collector.database.Database;
import collector.database.DbDevice;
import core.time.schedule.PeriodicSchedule;
import core.time.TimeSpan;
import core.io.port.Parity;
import collector.common.CollectorWorker;
import collector.common.CollectorDevice;
import collector.common.route.DirectSerialRoute;
import collector.common.parameters.DeviceAction;
import collector.appdrivers.teplokom.vkt7like.Vkt7likeDriver;

/**
 * Launches all
 */
class Collector {
	/**
	 * Entry point
	 */
	public static function main() {
		// Prepare database
		Database.instance.open();

		var worker = new CollectorWorker();
		worker.registerDriver(Vkt7likeDriver);

		var schedule = new PeriodicSchedule(new TimeSpan({seconds: 10}));
		var script = worker.newScript("Collect data", schedule);

		var devices = Database.instance.getByType(DbDevice);
		for (device in devices) {
			if (device.routes == null || device.routes.length < 1)
				continue;

			var routeId = device.routes[0];
			var route = Database.instance.getById(routeId);
			if (route == null)
				continue;
			
			var devRoute:DeviceRoute = null;

			var directSerialRoute:DbSerialRoute = cast route;
			if (directSerialRoute != null) {				
				devRoute = new DirectSerialRoute(directSerialRoute.port, directSerialRoute.speed, directSerialRoute.byteType);
			}

			if (devRoute == null)
				continue;
			
			var colDevice = new CollectorDevice(device.serial, device.modelType, device.protocolType, devRoute);
			script.addDevice(colDevice);
		}

		script.addAction(new DeviceAction(ActionType.ReadDateTime));
					
		worker.start();
	}
}

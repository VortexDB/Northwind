package collector;

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

		// var worker = new CollectorWorker();
		// worker.registerDriver(Vkt7likeDriver);

		// var schedule = new PeriodicSchedule(new TimeSpan({seconds: 10}));
		// var script = worker.newScript("Collect data", schedule);

		// var devices = Database.instance.getEntities(DbDevice);
		// for (device in devices) {
		// 	//new CollectorDevice()			
		// }

		var dev:DbDevice = Database.instance.getById(1);
		var route = Database.instance.getById(dev.routes[0]);
		trace(route);
		// var route = Database.instance.createEntity(DbSerialRoute);
		// route.port = "COM4";
		// route.speed = 115200;
		// route.byteType = "8N1";
		// Database.instance.saveEntity(route);

		// dev.routes = [route.id];
		// Database.instance.saveEntity(dev);

		// script.addDevice(new CollectorDevice("2313", "Vkt7", "ModbusRtuProtocol", new DirectSerialRoute("COM4", 9600, {
		// 	dataBits: 8,
		// 	parity: Parity.None,
		// 	stopBits: 1
		// })));
		// script.addAction(new DeviceAction(ActionType.ReadDateTime));
		// worker.start();
	}
}

package collector;

import collector.common.DeviceRoute.TcpClientRoute;
import core.time.schedule.PeriodicSchedule;
import core.time.TimeSpan;
import collector.common.CollectorWorker;
import collector.common.CollectorDevice;
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
		var worker = new CollectorWorker();
		worker.registerDriver(Vkt7likeDriver);

		var schedule = new PeriodicSchedule(
			new TimeSpan({seconds:10})
		);
		var script = worker.newScript("Collect data", schedule);
		script.addDevice(new CollectorDevice("2313", "Vkt7", "ModbusRtuProtocol", new TcpClientRoute("localhost", 26301)));		
		script.addAction(new DeviceAction(ActionType.ReadDateTime));
		worker.start();
	}
}

package collector;

import core.time.schedule.PeriodicSchedule;
import core.time.TimeSpan;
import collector.common.CollectorWorker;

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
		worker.newScript("Collect data", schedule);
		worker.start();
	}
}

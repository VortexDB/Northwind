package collector;

import collector.common.CollectorWorker;

/**
 * Launches all
 */
class Collector {
    /**
     * Entry point
     */
    public static function main() {
        var worker = new CollectorWorker();
        worker.start();
    }
}
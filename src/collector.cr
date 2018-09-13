require "benchmark"
require "collector_common"
require "app_drivers"

collector = Collector::CollectorWorker.new
# collector.registerDriver()

collector.start

loop do
    sleep 1
end
require "benchmark"
require "collector_common"

collector = Collector::CollectorWorker.new
collector.start

loop do
    sleep 1
end
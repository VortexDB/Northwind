require "benchmark"
require "../protocols/**"
require "./collector_worker"

collector = Collector::CollectorWorker.new
collector.start

loop do
    sleep 1
end
require "benchmark"
require "./database/**"
require "./utils/**"
require "./collector/**"

collector = Collector::CollectorWorker.new
collector.start

loop do
    sleep 1
end
require "benchmark"


collector = Collector::CollectorWorker.new
collector.start

loop do
    sleep 1
end
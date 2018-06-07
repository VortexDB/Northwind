require "benchmark"
require "../**"

collector = CollectorWorker.new
collector.start

loop do
    sleep 1
end
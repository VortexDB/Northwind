require "benchmark"
require "./northwind/**"

collector = Collector.new
collector.start

loop do
    sleep 1
end
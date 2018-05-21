require "./collector/collector"

collector = Collector.new
collector.start

loop do
    sleep 1
end
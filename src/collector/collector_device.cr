module Collector
  # Device that uses collector
  class CollectorDevice
    # Driver to collect data
    getter driver : CollectorDriver

    # Device route for connection
    # TODO: routes
    getter route : DeviceRoute

    # Data source to write data
    getter dataSource : EntityDataSource

    def initialize(@driver, @route, @dataSource)
    end
  end
end

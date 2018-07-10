require "../database/*"

module Collector
  # Device that uses collector
  class CollectorDevice
    # Driver to collect data
    getter driver : CollectorDriver

    # Device route for connection
    # TODO: routes
    getter route : DeviceRoute

    # Device protocol name
    getter protocolName : String

    # Data source to write data
    getter dataSource : Database::EntityDataSource

    def initialize(@driver, @route, @protocolName, @dataSource)
    end
  end
end

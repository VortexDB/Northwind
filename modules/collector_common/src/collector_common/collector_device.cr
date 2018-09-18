module Collector
  # Device that uses collector
  class CollectorDevice
    # Driver to collect data
    property driver : CollectorDriver?

    # Device route for connection
    # TODO: routes
    getter route : DeviceRoute

    # Device type name
    # TODO: database device
    getter deviceType : String

    # Device protocol name
    getter protocolType : String

    # Data source to write data
    getter dataSource : Database::EntityDataSource

    def initialize(
      deviceType,
      @protocolType,
      @route,
      #@driver,      
      @dataSource)

      @deviceType = deviceType.to_s
    end
  end
end

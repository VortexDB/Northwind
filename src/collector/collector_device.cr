# Device that uses collector
class CollectorDevice
    # Driver to collect data
    getter driver : CollectorDriver

    # Device route for connection
    # TODO: routes
    getter route : DeviceRoute
    
    def initialize(@driver, @route)
    end
end
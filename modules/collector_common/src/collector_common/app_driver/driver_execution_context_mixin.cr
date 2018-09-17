module Collector
    # Mixin that adds execution context to driver
    # Works only with CollecterMeterDriver
    module DriverExecutionContextMixin(TExecutionContext)
        # Return current execution eontext for device
        # TODO: cache
        def executionContext : TExecutionContext            
            return getExecutionContext
        end

        # Return execution context
        abstract def getExecutionContext : TExecutionContext
    end
end
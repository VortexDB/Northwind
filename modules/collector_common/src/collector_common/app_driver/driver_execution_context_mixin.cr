module Collector
    # Mixin that adds execution context to driver
    module DriverExecutionContextMixin(TExecutionContext)
        # Context for driver executers
        @executionContext : TExecutionContext?

        def executionContext : TExecutionContext
            if @executionContext == nil
            end

            return
        end

        # Return execution context
        abstract def createExecutionContext : TExecutionContext        
    end
end
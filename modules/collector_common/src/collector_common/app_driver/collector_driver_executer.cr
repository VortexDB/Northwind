module Collector
    # Executer that works in the context of driver
    abstract class CollectorDriverExecuter(TResponse)
        # Execution context
        getter executionContext : ExecutionContext

        def initialize(@executionContext : ExecutionContext)
        end

        def initialize(@executionContext : ExecutionContext, &block : TResponse -> Void)
            execute(&block)
        end

        # Execute and return some response
        abstract def execute(&block : TResponse -> Void) : Void

        # Execute and return as array
        def execute : Array(TResponse)
            res = Array(TResponse).new
            execute do |value|
                res << value
            end
            return res
        end
    end
end
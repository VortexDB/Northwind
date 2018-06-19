module Spt96xDriver
    # Response after read date archive
    class ReadDateArchiveResponse
        # Parameter info
        getter parameter : RequestParameter

        # Start date
        getter startDate : Time

        # Start date
        getter endDate : Time

        # Values
        getter values : Array(Float64)

        def initialize(@parameter, @startDate, @endDate, @values)            
        end
    end
end
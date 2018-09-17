module Collector
    # Mixin for driver that adds protocol
    module DriverProtocolMixin(TProtocol)
        @@protocol : TProtocol?

        # Protocol of driver
        def self.protocol : TProtocol
            if @@protocol == nil
                @@protocol = TProtocol.new
            end
            return @@protocol
        end

        # Protocol of driver
        def protocol : TProtocol
            self.protocol
        end
    end
end
module Vkt7Driver
    # Read Vkt7 item info
    class ItemInfoReader
        def initialize(@protocol)            
        end

        # Execute reading
        def execute
            ItemTypeSelector.new(Vkt7ItemType::Property).execute
        end
    end
end
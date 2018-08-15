module Vkt7Driver
    # Read Vkt7 item value
    class ItemValueReader < BaseExecuter(Vkt7ElementData)
        # All elements
        getter elements = Set(ElementRequest).new

        # Add element type
        def addItemType(element : ElementRequest) : Void
            @elements.add(element)
        end

        # Execute and iterate values in block
        def execute(&block : Vkt7ElementData -> Void) : Void
        end
    end
end
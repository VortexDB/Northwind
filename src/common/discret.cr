# Discret type
enum DiscretType
    None,
    Second,
    Minute,
    Hour,
    Day,
    Month,
    Year
end

# Discret
class Discret
    # Discret type
    getter discretType : DiscretType

    # Discret value
    getter discretValue : Int32

    def initialize(@discretType, @discretValue)        
    end
end
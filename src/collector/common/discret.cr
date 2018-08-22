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

    # Calc hash
    def hash
        discretType.hash ^ discretValue
    end

    # Equal objects
    def ==(other : Discret)
        return (discretType == other.discretType) && (discretValue == other.discretValue)
    end
end
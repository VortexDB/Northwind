# Measure parameter
class MeasureParameter
    # Measure type
    getter measureType : MeasureType

    # Discret of parameter
    getter discret : Discret

    def initialize(@measureType, @discret)        
    end
    
    # Calc hash
    def hash
        measureType.hash ^ discret.hash
    end

    # Compare objects
    def ==(obj : MeasureParameter)
        hash == obj.hash
    end
end
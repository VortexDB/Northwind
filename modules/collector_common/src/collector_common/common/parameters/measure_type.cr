module Device
  # Base measure
  enum BaseMeasureType
    Energy,
    Power,
    Current,
    Voltage,
    Temperature,
    Pressure,
    Flow
  end

  # Measure type for electricity
  class MeasureType
    # Active energy
    ACTIVE_ENERGY = MeasureType.new("ActiveEnergy", BaseMeasureType::Energy)

    # Reactive energy
    REACTIVE_ENERGY = MeasureType.new("ReactiveEnergy", BaseMeasureType::Energy)

    # Absolute pressure
    ABSOLUTE_PRESSURE = MeasureType.new("AbsolutePressure", BaseMeasureType::Pressure)

    # Temperature
    TEMPERATURE = MeasureType.new("Temperature", BaseMeasureType::Temperature)

    # Name of parameter
    getter name : String

    # Base measure type
    getter baseMeasure : BaseMeasureType

    def initialize(@name, @baseMeasure)
    end

    def hash
      name.hash
    end

    def ==(other : MeasureType)
      name == other.name && baseMeasure == other.baseMeasure
    end
  end
end

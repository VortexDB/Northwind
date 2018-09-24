package collector.common.parameters;

/**
 * Discret type
 */
enum DiscretType {
	None;
	Second;
	Minute;
	Hour;
	Day;
	Month;
	Year;
}

/**
 * Discret of some data
 */
class Discret {
	/**
	 * Discret type
	 */
	public final discretType:DiscretType;

	/**
	 * Discret value
	 */
	public final discretValue:Int;

	/**
	 * Constructor
	 * @param discretType
	 * @param discretValue
	 */
	public function new(discretType:DiscretType, discretValue:Int) {
		this.discretType = discretType;
		this.discretValue = discretValue;
	}

    /**
	 * Calc hash
	 * @return Int
	 */
	public function hashCode():Int {
		return discretType.getIndex() ^ discretValue;
	}

	/**
	 * Compare objects
	 * @param other
	 * @return Bool
	 */
	public function equals(other:Dynamic):Bool {
		if (Std.is(other, Discret)) {
			return hashCode() == cast(other, Discret).hashCode();
		}

		return false;
	}
}

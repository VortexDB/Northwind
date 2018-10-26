package collector.common.appdriver;

using core.utils.StringHelper;

/**
 * Key for map of device driver
 */
class DriverMapKey {
	/**
	 * Device type
	 */
	public final deviceType:String;

	/**
	 * Protocol type
	 */
	public final protocolType:String;

	/**
	 * Constructor
	 */
	public function new(deviceType:String, protocolType:String) {
		this.deviceType = deviceType;
		this.protocolType = protocolType;
	}

	/**
	 * Calc hash
	 * @return Int
	 */
	public function hashCode():Int {
		return deviceType.hashCode() ^ protocolType.hashCode();
	}

	/**
	 * Compare objects
	 * @param other
	 * @return Bool
	 */
	public function equals(other:Dynamic):Bool {
		if (Std.is(other, DriverMapKey)) {
			return hashCode() == cast(other, DriverMapKey).hashCode();
		}

		return false;
	}

	/**
	 * Convert to string
	 * @return String
	 */
	public function toString():String {
		return 'DeviceType: ${deviceType} ProtocolType: ${protocolType}';
	}
}
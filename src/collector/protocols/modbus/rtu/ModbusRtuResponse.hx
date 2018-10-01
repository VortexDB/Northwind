package collector.protocols.modbus.rtu;

/**
 * Response of ModbusRtuProtocol
 */
class ModbusRtuResponse {
    /**
	 * Device network address
	 */
	public final networkAddress:Int;

    /**
	 * Constructor
	 */
	public function new(networkAddress:Int) {
		this.networkAddress = networkAddress;
	}
}
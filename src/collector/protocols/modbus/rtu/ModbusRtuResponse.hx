package collector.protocols.modbus.rtu;

import haxe.io.Bytes;

/**
 * Response of ModbusRtuProtocol
 */
class ModbusRtuResponse {
    /**
	 * Device network address
	 */
	public final networkAddress:Int;

	/**
	 * Modbus function id
	 */
	public final functionId:Int;

	/**
	 * Data of packet
	 */
	public final data:Bytes;

    /**
	 * Constructor
	 */
	public function new(networkAddress:Int, functionId:Int, data:Bytes) {
		this.networkAddress = networkAddress;
		this.functionId = functionId;
		this.data = data;
	}
}
package collector.protocols.modbus.rtu;

import haxe.io.Bytes;

/**
 * Abstract class
 * Data that transfered by Modbus Rtu Protocol
 */
class ModbusRtuRequest {
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

	/**
	 * Return function ID
	 * @return Int
	 */
	public function functionId():Int {
		throw "Not implemented";
	}

	/**
	 * Return binary data of request
	 */
	public function getData():Bytes {
		throw "Not implemented";
	}
}

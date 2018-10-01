package collector.protocols.modbus.rtu.requests;

import haxe.io.Bytes;
import core.io.BinaryData;

class PresetMultipleRegistersRequest extends ModbusRtuRequest {
	/**
	 * Function id
	 */
	public static inline final FUNCTION_ID = 0x10;

	/**
	 * Response length
	 */
	public static inline final RESPONSE_LENGTH = 2;

	/**
	 * Start address to read
	 */
	public final address:Int;

	/**
	 * Length to read
	 */
	public final length:Int;

	/**
	 * Data to write
	 */
	public final data:Bytes;

	/**
	 * Constructor
	 * @param networkAddress
	 * @param address
	 * @param length
	 * @param data
	 * @param knownLength = RESPONSE_LENGTH
	 */
	public function new(networkAddress, address, length, data, knownLength = RESPONSE_LENGTH) {
		super(networkAddress, knownLength);
		this.address = address;
		this.length = length;
		this.data = data;
	}

    /**
     * Return function ID
     * @return Int
     */
    override function functionId():Int {
        return FUNCTION_ID;
    }

	/**
	 * Return binary data of request
	 * @return Bytes
	 */
	public override function getData():Bytes {
		var binary = new BinaryData();
		binary.addInt16(address);
		binary.addInt16(length);
		binary.addBytes(data);
		return binary.toBytes();
	}
}

package collector.protocols.modbus.rtu.requests;

import core.io.BinaryData;
import haxe.io.Bytes;

/**
 * Base modbus request
 */
class ReadHoldingRegistersRequest extends ModbusRtuRequest {
	/**
	 * Function id
	 */
	public static inline final FUNCTION_ID = 0x03;

	/**
	 * Start address to read. UInt16
	 */
	public final address:Int;

	/**
	 * Length to read
	 */
	public final length:Int;

	/**
	 * Constructor
	 * @param networkAddress 
	 * @param address 
	 * @param length 
	 */
	public function new(networkAddress, address, length) {
		super(networkAddress); 
		this.address = address;
		this.length = length;
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
	 */
	override function getData():Bytes {
		var binary = new BinaryData();
		binary.addInt16(address);
		binary.addInt16(length);		
		return binary.toBytes();
	}
}

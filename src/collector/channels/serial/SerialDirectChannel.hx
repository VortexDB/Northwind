package collector.channels.serial;

import core.io.port.SerialPort;
import haxe.io.Bytes;
import collector.common.util.NorthwindException;
import collector.common.channel.ClientTransportChannel;
import collector.common.channel.IBinaryChannel;
import collector.common.route.DeviceRoute;
import collector.common.route.DirectSerialRoute;

/**
 * Channel for communicating direct with serial port
 */
class SerialDirectChannel extends ClientTransportChannel implements IBinaryChannel {
    /**
     * For working with serial port
     */
    private final port:SerialPort;

    /**
     * Constructor
     * @param route 
     */
    public function new(route:DeviceRoute) {
        super(route);
        var serialRoute:DirectSerialRoute = cast route;
        if (serialRoute == null)
            throw new NorthwindException("Wrong route type");
        
        port = new SerialPort(serialRoute.portName, serialRoute.speed, serialRoute.byteType);
    }

	/**
	 * Open channel with timeout in milliseconds
	 */
	public override function open(timeout:Int):Void {
        port.open();
    }

	/**
	 * Close channel
	 */
	public override function close():Void {
		port.close();
	}

	/**
	 * Write bytes
	 * @param data
	 */
	public function write(data:Bytes):Void {
		trace(data.toHex());
		port.write(data);
	}

	/**
	 * Read bytes from channel
	 * @return Bytes
	 */
	public function read():Bytes {		
		var res = port.read();
		trace(res.toHex());
		return res;
	}
}

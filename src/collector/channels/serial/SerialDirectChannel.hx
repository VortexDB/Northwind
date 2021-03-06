package collector.channels.serial;

import core.async.future.Future;
import core.async.stream.StreamController;
import core.async.stream.Stream;
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
	 * Controller for data stream
	 */
	private final dataController:StreamController<Bytes>;

	/**
	 * Data stream
	 */
	public var onData:Stream<Bytes>;

	/**
	 * Constructor
	 * @param route
	 */
	public function new(route:DeviceRoute) {
		super(route);
		var serialRoute:DirectSerialRoute = cast route;
		if (serialRoute == null)
			throw new NorthwindException("Wrong route type");

		this.dataController = new StreamController<Bytes>();
		this.onData = this.dataController.stream;
		port = new SerialPort(serialRoute.portName, serialRoute.speed, serialRoute.byteType);
		port.onData.listen((data) -> {
			dataController.add(data);
		});
	}

	/**
	 * Open channel with timeout in milliseconds
	 */
	public override function open(timeout:Int):Future<Bool> {
		// TODO: timeout
		return Future.sync(() -> {
			port.open();
			return true;
		});
	}

	/**
	 * Close channel
	 */
	public override function close():Future<Bool> {
		var completer = new CompletionFuture<Bool>();
		port.close().onSuccess((_) -> {
			dataController.close();
			completer.complete(true);
		});		

		return completer;
	}

	/**
	 * Write bytes
	 * @param data
	 */
	public function write(data:Bytes):Void {
		port.write(data);
	}
}

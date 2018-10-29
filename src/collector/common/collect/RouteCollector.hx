package collector.common.collect;

import collector.common.channel.ClientTransportChannel;
import collector.common.appdriver.DriverMapKey;
import core.async.future.Future;
import collector.common.route.DeviceRoute;

using core.utils.IterableHelper;

/**
 * Collect data from devices by route
 */
class RouteCollector {
	/**
	 * Context of collector script
	 */
	public final owner:IScriptContext;

	/**
	 * Route for devices
	 */
	public final route:DeviceRoute;

	/**
	 * Devices on route
	 */
	public final routeDevices:Array<CollectorDevice>;

	/**
	 * Constructor
	 */
	public function new(owner:IScriptContext, route:DeviceRoute, routeDevices:Array<CollectorDevice>) {
		this.owner = owner;
		this.route = route;
		this.routeDevices = routeDevices;
	}

	/**
	 * Return future that will signal about complete
	 * @return Future<Bool>
	 */
	public function collect():Future<Bool> {
		var channel = owner.getChannelByRoute(route);
		var completer = new CompletionFuture<Bool>();

		trace('Opening port: ${route.toString()}');
		channel.open(1000)
			.onSuccess((_)
				-> {
					trace('Port opened');
					var deviceMap = routeDevices.groupdBy((e) -> {
						return e.hashCode();
					});
					for (devices in deviceMap) {
						if (devices.length < 1)
							continue;

						var device = devices[0];
						var driver = owner.getDriver(new DriverMapKey(device.deviceType, device.protocolType));
						if (driver == null) {
							trace('Driver for device ${device.deviceType} not found');
							continue;
						}
						driver.protocol.channel = channel;
						// TODO: register collector to have possibility cancel
						var driverCollector = new DriverCollector(owner, driver, devices);
						// TODO: timeout
						// TODO: notify on error
						driverCollector.collect().onSuccess((e) -> {
							// 
						});
					}
				})
			.onError((ex) -> {
				completer.throwError(ex);
			});

		// var clientChannel:ClientTransportChannel = cast channel;
		// // Close channel if it's a ClientChannel
		// if (clientChannel != null) {
		// 	clientChannel.close();
		// 	trace('Port closed');
		// }			
		return completer;
	}

	/**
	 * Stop execution
	 * @return Future<Bool>
	 */
	public function stop():Future<Bool> {
		return null;
	}
}

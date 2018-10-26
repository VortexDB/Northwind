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
		trace('Opening port: ${route.toString()}');
		channel.open(1000)
			.onSuccess((_)
				-> {
					trace('Port opened');
					// For grouping by driver key
					var driverKeys = new Array<DriverMapKey>();
					for (device in routeDevices) {
						var driverKey = new DriverMapKey(device.deviceType, device.protocolType);
						driverKeys.push(driverKey);
					}
					var driverKeyGroups = driverKeys.groupdBy((e) -> {
						return e.hashCode();
					});

					for (driverKey in driverKeyGroups) {
						var first = driverKey[0];
						var driver = owner.getDriver(first);
						if (driver == null) {
							trace('Driver for device ${first.deviceType} not found');
							continue;
						}
						driver.protocol.channel = channel;
						//collectByDriver(driver, routeDevices);
					}
				})
			.onError((ex) -> {
				trace(ex);
			})
			.onComplete((_)
				-> {
					var clientChannel:ClientTransportChannel = cast channel;
					// Close channel if it's a ClientChannel
					if (clientChannel != null) {
						clientChannel.close();
						trace('Port closed');
					}
				});
		return null;
	}

	/**
	 * Stop execution
	 * @return Future<Bool>
	 */
	public function stop():Future<Bool> {
		return null;
	}
}

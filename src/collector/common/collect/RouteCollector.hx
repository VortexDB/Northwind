package collector.common.collect;

import collector.common.channel.TransportChannel;
import collector.common.channel.ClientTransportChannel;
import collector.common.appdriver.DriverMapKey;
import core.async.future.Future;
import collector.common.route.DeviceRoute;

using core.utils.IterableHelper;

/**
 * Context for route collectors
 */
class RouteCollectorContext {
	/**
	 * Channel for route
	 */
	public final channel:TransportChannel;

	/**
	 * All collectors
	 */
	public final collectors:Array<DriverCollector>;

	/**
	 * Constructor
	 */
	public function new(channel:TransportChannel) {
		this.channel = channel;
		this.collectors = new Array<DriverCollector>();
	}
}

/**
 * Collect data from devices by route
 */
class RouteCollector {
	/**
	 * For signal of work completion
	 */
	private final completer:CompletionFuture<RouteCollector>;

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
	 * Process state change
	 * @param collector
	 */
	private function processStates(context:RouteCollectorContext, collector:DriverCollector) {
		context.collectors.remove(collector);
		if (context.collectors.length < 1) {
			if ((context.channel is ClientTransportChannel)) {				
				context.channel.close().onSuccess((_) -> {					
					completer.complete(this);					
				}).onError((ex) -> {
					trace(ex);
				});
			} else {				
				completer.complete(this);
			}
		}
	}

	/**
	 * Constructor
	 */
	public function new(owner:IScriptContext, route:DeviceRoute, routeDevices:Array<CollectorDevice>) {
		this.owner = owner;
		this.route = route;
		this.routeDevices = routeDevices;
		completer = new CompletionFuture<RouteCollector>();
	}

	/**
	 * Return future that will signal about complete
	 * @return Future<Bool>
	 */
	public function collect():Future<RouteCollector> {
		var channel = owner.getChannelByRoute(route);

		trace('Opening port: ${route.toString()}');
		channel.open(1000)
			.onSuccess((_)
				-> {
					trace('Port opened');
					var context = new RouteCollectorContext(channel);
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

						driver.initialize();
						driver.protocol.channel = channel;
						// TODO: register collector to have possibility cancel
						var driverCollector = new DriverCollector(owner, driver, devices);
						context.collectors.push(driverCollector);
						// TODO: timeout
						driverCollector.collect()
							.onSuccess((_)
								-> {
									// Change state
									// Complete if all is done
									processStates(context, driverCollector);
								})
							.onError((ex) -> {
								processStates(context, driverCollector);
								trace(ex);
							});
					}
				})
			.onError((ex) -> {
				completer.throwError(ex);
			});
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

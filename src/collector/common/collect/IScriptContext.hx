package collector.common.collect;

import collector.common.appdriver.CollectorDriver;
import collector.common.appdriver.DriverMapKey;
import collector.common.channel.TransportChannel;
import collector.common.route.DeviceRoute;

/**
 * Script executing context
 */
interface IScriptContext {
    /**
     * Get channel by route
     * @param route 
     */
    function getChannelByRoute(route:DeviceRoute):TransportChannel;

    /**
     * Return collector driver by driver key
     * @param key 
     * @return CollectorDriver
     */
    function getDriver(key:DriverMapKey):CollectorDriver;
}
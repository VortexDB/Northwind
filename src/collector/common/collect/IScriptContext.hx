package collector.common.collect;

import core.collections.HashSet;
import collector.common.parameters.MeasureParameter;
import collector.common.parameters.DeviceAction;
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

    /**
     * Get collect deep
     * @return Int
     */
    function getDeep():Int;

    /**
     * Get actions to execute
     * @return Array<DeviceAction>
     */
    function getActions():HashSet<DeviceAction>;

    /**
     * Get parameters to read
     * @return Array<DeviceAction>
     */
    function getParameters():HashSet<MeasureParameter>;
}
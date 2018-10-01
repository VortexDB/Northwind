package collector.common.channel;

import collector.common.route.DeviceRoute;

/**
 * Client channel that connects to some server
 */
class ClientTransportChannel extends TransportChannel {
    /**
     * Default read timeout in milleseconds
     */
    public static inline final DEFAULT_READ_TIMEOUT = 1000;

    /**
     * Default write timeout in milleseconds
     */
    public static inline final DEFAULT_WRITE_TIMEOUT = 1000;

    /**
     * Read timeout in milleseconds
     */
    public final readTimeout:Int;

     /**
     * Write timeout in milleseconds
     */
    public final writeTimeout:Int;

    /**
     * Constructor
     */
    public function new(route:DeviceRoute, readTimeout:Int = DEFAULT_READ_TIMEOUT, writeTimeout = DEFAULT_WRITE_TIMEOUT) {
        super(route);
        this.readTimeout = readTimeout;
        this.writeTimeout = writeTimeout;
    }
}
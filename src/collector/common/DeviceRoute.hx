package collector.common;

/**
 * Base route information to make connection for device
 */
class DeviceRoute {
}

/**
 * Information about tcp client connection
 */
class TcpClientRoute extends DeviceRoute {
    /**
     * Host to connect
     */
    public final hostOrIp : String;

    /**
     * Port to connect
     */
    public final port : Int;

    /**
     * Constructor
     * @param hostOrIp 
     * @param port 
     */
    public function new(hostOrIp:String, port:Int) {
        this.hostOrIp = hostOrIp;
        this.port = port;
    }
}
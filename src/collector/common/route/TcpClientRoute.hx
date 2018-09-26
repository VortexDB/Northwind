package collector.common.route;

using core.utils.StringHelper;

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

    /**
	 * Calc hash
	 * @return Int
	 */
	public function hashCode():Int {
		return hostOrIp.hashCode() ^ port;
	}

	/**
	 * Compare objects
	 * @param other
	 * @return Bool
	 */
	public function equals(other:Dynamic):Bool {
		if (Std.is(other, TcpClientRoute)) {
			return hashCode() == cast(other, TcpClientRoute).hashCode();
		}

		return false;
	}
}
package collector.common.route;

/**
 * Settings for byte type of serial port
 */
typedef ByteTypeSettings {
    /**
     * Data bits: 6,7,8
     */
    var DataBits:Int;

    /**
     * Parity: None, Even, Odd
     */
    var Parity:Parity;

    /**
     * Stop bits: 2, 1.5, 1
     */
    var StopBits:Int;
}

/**
 * Serial port direct connection route
 */
class DirectSerialRoute extends DeviceRoute {
    /**
     * Name of serial port
     */
    public final portName:String;

    /**
     * Port speed
     */
    public final speed:Int;

    /**
     * Byte type. Example: 8N1, 7E2
     */
    public final byteType:ByteTypeSettings;

    /**
     * Constructor
     */
    public function new(portName:String, speed:Int, byteType:ByteTypeSettings) {
        this.portName = portName;
        this.speed = speed;
        this.byteType = byteType;
    }
}
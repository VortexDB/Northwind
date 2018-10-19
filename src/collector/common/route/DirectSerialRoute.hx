package collector.common.route;

import core.io.port.ByteTypeSettings;

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

    /**
     * Convert to string
     */
    public function toString() {
        return 'Port: ${portName} Speed: ${speed} ByteType: ${byteType}';
    }
}
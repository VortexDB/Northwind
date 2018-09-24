package collector.appdrivers.teplokom.vkt7like;

import collector.common.appdriver.CollectorMeterDriver;
import collector.common.protocols.modbus.rtu.ModbusRtuProtocol;

/**
 * Driver for Vkt7 like driver
 */
@:keep
class Vkt7likeDriver extends CollectorMeterDriver {
    /**
     * Constructor
     */
    public function new() {
        super(["Vkt7"], new ModbusRtuProtocol());
    }
}
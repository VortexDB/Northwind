package collector.appdrivers.teplokom.vkt7like.common;

import collector.common.protocol.TransportProtocol;
import collector.common.appdriver.deviceinfo.DeviceInfo;
import collector.common.appdriver.ExecutionContext;

import collector.protocols.modbus.rtu.ModbusRtuProtocol;

/**
 * Execution context for vkt driver
 */
class VktExecuterContext extends ExecutionContext {
    /**
     * Model for device
     */
    public final model:VktModel;

    /**
     * Return modbus rtu protocol
     */
    public var modbusProtocol(get, never):ModbusRtuProtocol;
    private function get_modbusProtocol(): ModbusRtuProtocol {
        return cast(protocol, ModbusRtuProtocol);
    }

    /**
     * Constructor
     * @param deviceInfo 
     * @param protocol 
     */
    public function new(deviceInfo:DeviceInfo, protocol:TransportProtocol) {
        super(deviceInfo, protocol);
        // TODO: get from device
        model = new VktModel(1);
    }
}
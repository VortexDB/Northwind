package collector.appdrivers.teplokom.vkt7like.common;

import collector.protocols.modbus.rtu.ModbusRtuProtocol;
import collector.common.appdriver.ExecutionContext;

/**
 * Execution context for vkt driver
 */
class VktExecuterContext extends ExecutionContext {
    /**
     * Return modbus rtu protocol
     */
    public var modbusProtocol(get, never):ModbusRtuProtocol;
    private function get_modbusProtocol(): ModbusRtuProtocol {
        return cast(protocol, ModbusRtuProtocol);
    }
}
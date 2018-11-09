package webadmin.service;

/**
 * Interface for data service
 */
interface IService {
    /**
     * Load devices from server
     */
    public function loadDevices():Array<Device>;
}
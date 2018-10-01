package collector.appdrivers.teplokom.vkt7like.common;

/**
 * Model of device with data needed for executers
 */
class VktModel {
    /**
     * Network address of device
     */
    public final networkAddress:Int;

    /**
     * Constructor
     */
    public function new(networkAddress:Int) {
        this.networkAddress = networkAddress;
    }
}
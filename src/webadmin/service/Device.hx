package webadmin.service;

/**
 * Device data from service
 */
class Device {
    /**
     * Caption of device
     */
    public final caption:String;

    /**
     * Constructor
     * @param caption 
     */
    public function new(caption:String) {
        this.caption = caption;
    }
}
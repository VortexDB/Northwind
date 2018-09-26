package collector.common.util;

/**
 * Exception that throws Northwind app
 */
class NorthwindException {
    /**
     * Message
     */
    public final message:String;

    /**
     * Constructor
     * @param message 
     */
    public function new(message:String) {
        this.message = message;
    }
}
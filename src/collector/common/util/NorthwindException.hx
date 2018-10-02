package collector.common.util;

import core.utils.exceptions.Exception;
/**
 * Exception that throws Northwind app
 */
class NorthwindException extends Exception {    
    /**
     * Constructor
     * @param message 
     */
    public function new(message:String) {
        super(message);
    }
}
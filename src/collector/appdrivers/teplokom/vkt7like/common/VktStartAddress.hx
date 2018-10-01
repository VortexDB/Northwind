package collector.appdrivers.teplokom.vkt7like.common;

/**
 * Addresses to read/write data
 */
class VktStartAddress {
    /**
     * Start session address
     */
    public static inline final START_SESSION_ADDRESS = 0x3FFF;

    /**
     * Read time address
     */
    public static inline final TIME_ADDRESS = 0x3FFB;

    /**
     * Read data address
     */
    public static inline final READ_DATA_ADDRESS = 0x3FFE;

    /**
     * Read active element data
     */
    public static inline final READ_ACTIVE_ELEMENT = 0x3FFC;

    /**
     * Write data type
     */
    public static inline final WRITE_DATA_TYPE = 0x3FFD;

    /**
     * Write element types
     */
    public static inline final WRITE_ELEMENT_TYPES = 0x3FFF;
}
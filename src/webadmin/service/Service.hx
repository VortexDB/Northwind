package webadmin.service;

/**
 * Service type
 */
enum ServiceType {
    Work;
    Test;
}

/**
 * Service for getting data
 */
class Service {
    /**
     * Instance of service
     */
    public static var instance:IService;

    /**
     * Create service
     * @param serviceType 
     */
    public static function init(serviceType:ServiceType) {
        switch (serviceType) {
            case ServiceType.Work:
                instance = new TestService();
            case ServiceType.Test:
                instance = new TestService();
            default:
                throw "Unknown service type";
        }
    }

    /**
     * Private constructor
     */
    private function new() {
    }
}
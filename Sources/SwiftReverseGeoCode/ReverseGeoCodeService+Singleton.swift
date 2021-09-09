

public extension ReverseGeoCodeService {
    
    private static var service: ReverseGeoCodeService?
    private static var databasePath = "../Data/geocitydb.sqlite"

    static func SetDatabase(path:String) {
        databasePath = path
    }

    static var main:ReverseGeoCodeService {
        get {
            guard let unwrapservice = service else {
                service = ReverseGeoCodeService(database:databasePath)
                return service!
            }
            return unwrapservice
        }
    }

}
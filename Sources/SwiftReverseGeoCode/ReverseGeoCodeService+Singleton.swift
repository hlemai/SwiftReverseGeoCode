public extension ReverseGeoCodeService {

    /// SIngleton instance
    private static var service: ReverseGeoCodeService?
    /// default database path
    private static var databasePath = "../Data/geocitydb.sqlite"

    /// fix the path of the database for singleton instance
    /// mandatory if you want to a valide db in the singleton
    /// - parameter path: String representing the path of the database
    static func setDatabase(path: String) {
        databasePath = path
    }

    /// get Singleton instance
    static var main: ReverseGeoCodeService {
        guard let unwrapservice = service else {
            service = ReverseGeoCodeService(database: databasePath)
            return service!
        }
        return unwrapservice
    }

}

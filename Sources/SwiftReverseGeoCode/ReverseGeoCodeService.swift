import Foundation
import SQLite
import OSLog

/// Main service to provide a local reversed geocoding.
public class ReverseGeoCodeService {
    /// Connection to the database
    private var dbConnection: Connection?
    /// Logger
    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier ?? "SwiftReverseGeoCode",
        category: "ReverseGeoCodeService")

    /// instanciante a Service
    ///     - parameter database:path of the database to open, see documentation to create a database
    public init(database: String) {
        do {
            try dbConnection = Connection(database, readonly: true)
        } catch {
            logger.error("Error connecting to database : \(String(describing: error))")
        }
    }
    /// GetLocation at provided coordinate
    /// -   parameter latitude: Double signed latitude
    /// -   parameter longitude: Double signed longitude (East is positive, West is negative)
    ///
    /// - throws ReverseErrorException
    /// - returns LocationnDescription of the nearest point of interest.
    public func reverseGeoCode(latitude: Double, longitude: Double ) throws -> LocationDescription {
        guard let database = dbConnection else {
            logger.error("No online database")
            throw ReverseError.dbError("No connection")
        }
        // scale = Math.pow(Math.cos(latitude * Math.PI / 180), 2)
        let scale = pow(cos(latitude * Double.pi / 180), 2.0)
        let sql = """
                               SELECT * FROM everything WHERE id IN (
                                 SELECT feature_id
                                 FROM coordinates
                                 WHERE latitude BETWEEN :lat - 1.5 AND :lat + 1.5
                                 AND longitude BETWEEN :long  - 1.5 AND :long  + 1.5
                                 ORDER BY (
                                   (:lat - latitude) * (:lat - latitude) +
                                     (:long - longitude) * (:long - longitude) * :scale
                                 ) ASC
                                 LIMIT 1
                               )
                               """
        let stm = try database.prepare(sql)

        for row in stm.bind(latitude, longitude, scale) {
            guard let id = row[0] as? Int64,
                  let name = row[1] as? String ,
                  let adminame = row[3] as? String,
                  let countrycode = row[4] as? String,
                  let countryname = row[5] as? String,
                  let latitude = row[6] as? Double,
                  let longitude = row[7] as? Double
            else {
                logger.error("Error in unwraping location for \(latitude),\(longitude)")
                throw ReverseError.errorUnwraping
            }
            return LocationDescription(id: id,
                                       name: name,
                                       adminName: adminame,
                                       countryCode: countrycode,
                                       countryName: countryname,
                                       latitude: latitude, longitude: longitude)
        }
        logger.warning("Nothing here: \(latitude),\(longitude)")
        throw ReverseError.novalue
    }

}

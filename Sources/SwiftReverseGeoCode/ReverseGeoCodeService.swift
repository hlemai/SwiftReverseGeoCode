import Foundation
import SQLite
import OSLog

public class ReverseGeoCodeService {
    
    private var dbConnection: Connection?
    private let logger = Logger(subsystem:Bundle.main.bundleIdentifier ?? "SwiftReverseGeoCode",category: "ReverseGeoCodeService")
    
    public init(database:String) {
        do {
            try dbConnection = Connection(database,readonly: true)
        } catch {
            logger.error("Error connecting to database : \(String(describing:error))")
        }
    }
    
    public func ReverseGeoCode(latitude:Double, longitude:Double ) throws -> LocationDescription {
        guard let db = dbConnection else {
            logger.error("No online database")
            throw ReverseError.dbError("No connection")
        }
        //scale = Math.pow(Math.cos(latitude * Math.PI / 180), 2)
        let scale = pow(cos(latitude * Double.pi / 180),2.0)
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
        let stm = try db.prepare(sql)
        
        for row in stm.bind(latitude,longitude,scale) {
            guard let id = row[0] as? Int64,
                  let name = row[1] as? String ,
                  let adminame = row[3] as? String,
                  let countrycode = row[4] as? String,
                  let countryname = row[5] as? String,
                  let latitude = row[6] as? Double,
                  let longitude = row[7] as? Double
            else {
                throw ReverseError.errorUnwraping
            }
            return LocationDescription(id: id,
                                       name: name,
                                       adminName: adminame,
                                       countryCode: countrycode,
                                       countryName: countryname,
                                       latitude: latitude, longitude: longitude)
        }
        throw ReverseError.novalue
    }
    
}

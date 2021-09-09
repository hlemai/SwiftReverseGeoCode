//
//  ReverseError.swift
//  
//
//  Created by Hervé LEMAI on 09/09/2021.
//

import Foundation

/// error throw by the ReverseGeoCodeService
enum ReverseError : Error {
    /// error during the connection of the db
    case dbError(String)
    /// the location is in the middle of nowhere -> no POI near the location
    case novalue
    /// error unwrapping data from the database, shouldn't appears. Open an issue if it happen.
    case errorUnwraping
}

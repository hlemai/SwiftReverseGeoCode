//
//  Location Description.swift
//  
//
//  Created by Hervé LEMAI on 09/09/2021.
//

import Foundation

/// LocationDescription
/// struct used to describe the location
public struct LocationDescription {
    /// geoname id
    public let id:Int64
    /// name of the location (usualy name of the city)
    public let name:String
    /// name of the administrative area (State for US, Region for France, Land in Germany...
    public let adminName:String
    /// international code of the country
    public let countryCode:String
    /// name of the country
    public let countryName:String
    /// exact latitude of the POI
    public let latitude:Double
    /// exact longitude of the POI
    public let longitude:Double
}

//
//  File.swift
//  
//
//  Created by Hervé LEMAI on 09/09/2021.
//

import Foundation

enum ReverseError : Error {
    case dbError(String)
    case novalue
    case errorUnwraping
}

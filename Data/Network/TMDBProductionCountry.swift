//
//  TMDBProductionCountry.swift
//  NextUp
//
//  Created by Heet Patel on 17/12/2025.
//

import Foundation

struct TMDBProductionCountry : Codable {
    // MARK: Variables
    let countryCode: String
    let name: String
    
    // MARK: Coding Keys
    enum CodingKeys: String, CodingKey {
        case countryCode = "iso_3166_1"
        case name
    }
}

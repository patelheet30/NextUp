//
//  TMDBSearchResult.swift
//  NextUp
//
//  Created by Heet Patel on 17/12/2025.
//

import Foundation

struct TMDBSearchResult: Codable {
    // MARK: Variables
    let id: Int
    let mediaType: String
    let title: String?  // For movies
    let name: String?   // For TV shows
    let overview: String?
    let posterPath: String?
    let backdropPath: String?
    let releaseDate: String?      // For movies
    let firstAirDate: String?     // For TV shows
    
    // MARK: Coding Keys
    enum CodingKeys: String, CodingKey {
        case id
        case mediaType = "media_type"
        case title
        case name
        case overview
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case firstAirDate = "first_air_date"
    }
}

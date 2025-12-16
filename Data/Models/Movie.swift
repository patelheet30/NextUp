//
//  Movie.swift
//  NextUp
//
//  Created by Heet Patel on 16/12/2025.
//

import Foundation
import GRDB

struct Movie: Codable, FetchableRecord, PersistableRecord {
    let id: String
    let title: String
    let overview: String?
    let posterPath: String?
    let backdropPath: String?
    let releaseDate: Date?
    let runtime: Int? // in minutes
    let genres: [Genre]
    let tmdbRating: Double?
    let tmdbVoteCount: Int?
    let status: String?
    let originalLanguage: String?
    let productionCountries: [String]
}

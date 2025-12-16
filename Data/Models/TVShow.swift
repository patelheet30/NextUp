//
//  TVShow.swift
//  NextUp
//
//  Created by Heet Patel on 16/12/2025.
//

import Foundation
import GRDB

struct TVShow {
    let id: String
    let title: String
    let overview: String?
    let posterPath: String?
    let backdropPath: String?
    let firstAirDate: Date?
    let lastAirDate: Date?
    let numberOfSeasons: Int
    let numberOfEpisodes: Int
    let genres: [Genre]
    let tmdbRating: Double?
    let tmdbVoteCount: Int?
    let status: String?
    let networks: [String]
}

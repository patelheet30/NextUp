//
//  TMDBMovie.swift
//  NextUp
//
//  Created by Heet Patel on 16/12/2025.
//

import Foundation

struct TMDBMovie: Codable {
    // MARK: Variables
    let id: Int
    let title: String
    let overview: String?
    let posterPath: String?
    let backdropPath: String?
    let releaseDate: String?
    let runtime: Int?
    let genres: [TMDBGenre]
    let tmdbRating: Double?
    let tmdbVoteCount: Int?
    let status: String?
    let originalLanguage: String?
    let productionCountries: [TMDBProductionCountry]
    
    // MARK: Coding Keys
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case runtime
        case genres
        case tmdbRating = "vote_average"
        case tmdbVoteCount = "vote_count"
        case status
        case originalLanguage = "original_language"
        case productionCountries = "production_countries"
    }
    
    // MARK: Convert TMDBMovie to Movie
    func toDomainModel() -> Movie {
        return Movie(
            id: String(id),
            title: title,
            overview: overview,
            posterPath: posterPath,
            backdropPath: backdropPath,
            releaseDate: parseDate(from: releaseDate),
            runtime: runtime,
            genres: genres.map { $0.toDomainModel() },
            tmdbRating: tmdbRating,
            tmdbVoteCount: tmdbVoteCount,
            status: status,
            originalLanguage: originalLanguage,
            productionCountries: productionCountries.map { $0.name })
    }
    
    // MARK: Parse dates
    private func parseDate(from dateString: String?) -> Date? {
        guard let dateString = dateString else {return nil}
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: dateString)
    }
}

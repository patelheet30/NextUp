//
//  TMDBTVShow.swift
//  NextUp
//
//  Created by Heet Patel on 17/12/2025.
//

import Foundation

struct TMDBTVShow: Codable {
    // MARK: Variables
    let id: Int
    let name: String
    let overview: String?
    let posterPath: String?
    let backdropPath: String?
    let firstAirDate: String?
    let lastAirDate: String?
    let numberOfSeasons: Int
    let numberOfEpisodes: Int
    let genres: [TMDBGenre]
    let tmdbRating: Double?
    let tmdbVoteCount: Int?
    let status: String?
    let networks: [TMDBNetwork]
    
    // MARK: Coding Keys
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case overview
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case firstAirDate = "first_air_date"
        case lastAirDate = "last_air_date"
        case numberOfSeasons = "number_of_seasons"
        case numberOfEpisodes = "number_of_episodes"
        case genres
        case tmdbRating = "vote_average"
        case tmdbVoteCount = "vote_count"
        case status
        case networks
    }
    
    // MARK: Convert TMDBTVShow to TVShow
    func toDomainModel() -> TVShow {
        return TVShow(
            id: String(id),
            title: name,
            overview: overview,
            posterPath: posterPath,
            backdropPath: backdropPath,
            firstAirDate: parseDate(from: firstAirDate),
            lastAirDate: parseDate(from: lastAirDate),
            numberOfSeasons: numberOfSeasons,
            numberOfEpisodes: numberOfEpisodes,
            genres: genres.map { $0.toDomainModel() },
            tmdbRating: tmdbRating,
            tmdbVoteCount: tmdbVoteCount,
            status: status,
            networks: networks.map { $0.name }
        )
    }
    
    // MARK: Parse dates
    private func parseDate(from dateString: String?) -> Date? {
        guard let dateString = dateString else { return nil }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: dateString)
    }
}

//
//  TMDBSeason.swift
//  NextUp
//
//  Created by Heet Patel on 17/12/2025.
//

import Foundation

struct TMDBSeason: Codable {
    // MARK: Variables
    let id: Int
    let seasonNumber: Int
    let name: String
    let overview: String?
    let posterPath: String?
    let airDate: String?
    let episodes: [TMDBEpisode]
    
    // MARK: Coding Keys
    enum CodingKeys: String, CodingKey {
        case id
        case seasonNumber = "season_number"
        case name
        case overview
        case posterPath = "poster_path"
        case airDate = "air_date"
        case episodes
    }
    
    // MARK: Convert TMTBSeason to Season
    func toDomainModel(tvShowId: String) -> Season {
        return Season(
            id: String(id),
            seasonNumber: seasonNumber,
            tvShowId: tvShowId,
            name: name,
            overview: overview,
            posterPath: posterPath,
            airDate: parseDate(from: airDate),
            episodeCount: episodes.count
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

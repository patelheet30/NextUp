//
//  TMDBEpisode.swift
//  NextUp
//
//  Created by Heet Patel on 17/12/2025.
//

import Foundation

struct TMDBEpisode: Codable {
    // MARK: Variables
    let id: Int
    let episodeNumber: Int
    let seasonNumber: Int
    let name: String
    let overview: String?
    let stillPath: String?
    let airDate: String?
    let runtime: Int?
    
    // MARK: Coding Keys
    enum CodingKeys: String, CodingKey {
        case id
        case episodeNumber = "episode_number"
        case seasonNumber = "season_number"
        case name
        case overview
        case stillPath = "still_path"
        case airDate = "air_date"
        case runtime
    }
    
    // MARK: Convert TMDBEpisode to Episode
    func toDomainModel(tvShowId: String, seasonId: String) -> Episode {
        return Episode(
            id: String(id),
            seasonId: seasonId,
            tvShowId: tvShowId,
            episodeNumber: episodeNumber,
            seasonNumber: seasonNumber,
            name: name,
            overview: overview,
            stillPath: stillPath,
            airDate: parseDate(from: airDate),
            runtime: runtime
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

//
//  TVShowRepositoryProtocol.swift
//  NextUp
//
//  Created by Heet Patel on 16/12/2025.
//

import Foundation
import GRDB

protocol TVShowRepositoryProtocol {
    
    // MARK: - Fetch Operations
    func fetchTVShow(id: String) throws -> TVShow?
    func fetchAllTVShows() throws -> [TVShow]
    func searchTVShows(query: String) throws -> [TVShow]
    
    // MARK: - Season Operations
    func fetchSeasons(tvShowId: String) throws -> [Season]
    func fetchSeason(tvShowId: String, seasonNumber: Int) throws -> Season?
    func saveSeason(_ season: Season) throws
    func saveSeasons(_ seasons: [Season]) throws
    
    // MARK: - Episode Operations
    func fetchEpisodes(tvShowId: String, seasonNumber: Int) throws -> [Episode]
    func fetchEpisode(id: String) throws -> Episode?
    func fetchEpisode(tvShowId: String, seasonNumber: Int, episodeNumber: Int) throws -> Episode?
    func saveEpisode(_ episode: Episode) throws
    func saveEpisodes(_ episodes: [Episode]) throws
    
    // MARK: - Write Operations
    func saveTVShow(_ tvShow: TVShow) throws
    func saveTVShows(_ tvShows: [TVShow]) throws
    func deleteTVShow(id: String) throws
    
    // MARK: - Cache Management
    func isTVShowCached(id: String) throws -> Bool
    func getLastSynced(id: String) throws -> Date?
}

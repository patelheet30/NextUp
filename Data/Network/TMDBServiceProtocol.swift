//
//  TMDBServiceProtocol.swift
//  NextUp
//
//  Created by Heet Patel on 17/12/2025.
//

import Foundation

protocol TMDBServiceProtocol {
    
    func searchMulti(query: String, page: Int) async throws -> TMDBSearchResponse<TMDBSearchResult>
    func searchMovies(query: String, page: Int) async throws -> TMDBSearchResponse<TMDBMovie>
    func searchTVShow(query: String, page: Int) async throws -> TMDBSearchResponse<TMDBTVShow>
    
    func fetchMovieDetails(id: Int) async throws -> TMDBMovie
    func fetchSimilarMovies(id: Int, page: Int) async throws -> TMDBSearchResponse<TMDBMovie>
    
    func fetchTVShowDetails(id: Int) async throws -> TMDBTVShow
    func fetchSeasonDetails(tvShowId: Int, seasonNumber: Int) async throws -> TMDBSeason
    func fetchEpisodeDetails(tvShowId: Int, seasonNumber: Int, episodeNumber: Int) async throws -> TMDBEpisode
    func fetchSimilarTVShows(id: Int, page: Int) async throws -> TMDBSearchResponse<TMDBTVShow>
    
    func fetchTrending(mediaType: String, timeWindow: String) async throws -> TMDBSearchResponse<TMDBSearchResult>
    func fetchUpcomingMovies(page: Int) async throws -> TMDBSearchResponse<TMDBMovie>
    func fetchOnTheAirTVShows(page: Int) async throws -> TMDBSearchResponse<TMDBTVShow>
}

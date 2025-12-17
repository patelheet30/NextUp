//
//  TMDBService.swift
//  NextUp
//
//  Created by Heet Patel on 17/12/2025.
//

import Foundation

class TMDBService: TMDBServiceProtocol {
    private let session: URLSession
    private let decoder: JSONDecoder
    private let baseURL: String
    private let apiKey: String
    
    // MARK: Initialise TMDBService
    init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = TimeInterval(AppConfiguration.API.requestTimeout)
        self.session = URLSession(configuration: configuration)
        
        self.decoder = JSONDecoder()
        self.dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        self.baseURL = AppConfiguration.api.baseURL
        self.apiKey = AppConfiguration.api.apiKey
    }
    
    // MARK: Private helper methods
    private func buildURL(endpoint: String, queryItems: [URLQueryItem]) throws -> URL {
        guard var components = URLComponents(string: baseURL + endpoint) else {
            throw TMDBError.invalidURL
        }
        components.queryItems = queryItems
        
        guard let url = components.url else {
            throw TMDBError.invalidURL
        }
        
        return url
    }
    
    private func buildRequest(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }
    
    private func performRequest<T: Codable>(endpoint: String, queryItems: [URLQueryItem]) async throws -> T{
        let url = try buildURL(endpoint: endpoint, queryItems: queryItems)
        let request = buildRequest(url: url)
        
        let (date, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw TMDBError.invalidResponse
        }
        
        if httpResponse.statusCode == 429 {
            throw TMDBError.rateLimitExceeded
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw TMDBError.httpError(statusCode: httpResponse.statusCode)
        }
        
        do {
            let decodedResponse = try decoder.decode(T.self, from: data)
            return decodedResponse
        } catch {
            throw TMDBError.decodingError(error)
        }
    }
    
    // MARK: Search Methods
    func searchMulti(query: String, page: Int) async throws -> TMDBSearchResponse<TMDBSearchResult> {
        let endpoint = "search/multi"
        let queryItems = [
            URLQueryItem(name: "query", value: query)
            URLQueryItem(name: "page", value: String(page))
        ]
        return try await performRequest(endpoint: endpoint, queryItems: queryItems)
    }
    
    func searchMovies(query: String, page: Int) async throws -> TMDBSearchResponse<TMDBMovie> {
        let endpoint = "search/movie"
        let queryItems = [
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "page", value: String(page))
        ]
        return try await performRequest(endpoint: endpoint, queryItems: queryItems)
    }
    
    func searchTVShow(query: String, page: Int) async throws -> TMDBSearchResponse<TMDBTVShow> {
        let endpoint = "search/tv"
        let queryItems = [
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "page", value: String(page))
        ]
        return try await performRequest(endpoint: endpoint, queryItems: queryItems)
    }
    
    // MARK: Movie Methods
    func fetchMovieDetails(id: Int) async throws -> TMDBMovie {
        let endpoint = "movie/\(id)"
        return try await performRequest(endpoint: endpoint, queryItems: [])
    }
    
    func fetchSimilarMovies(id: Int, page: Int) async throws -> TMDBSearchResponse<TMDBMovie> {
        let endpoint = "movie/\(id)/similar"
        let queryItems = [
            URLQueryItem(name: "page", value: String(page))
        ]
        return try await performRequest(endpoint: endpoint, queryItems: queryItems)
    }
    
    // MARK: TV Show Methods
        
    func fetchTVShowDetails(id: Int) async throws -> TMDBTVShow {
        let endpoint = "tv/\(id)"
        return try await performRequest(endpoint: endpoint, queryItems: [])
    }
        
    func fetchSeasonDetails(tvShowId: Int, seasonNumber: Int) async throws -> TMDBSeason {
        let endpoint = "tv/\(tvShowId)/season/\(seasonNumber)"
        return try await performRequest(endpoint: endpoint, queryItems: [])
    }
        
    func fetchEpisodeDetails(tvShowId: Int, seasonNumber: Int, episodeNumber: Int) async throws -> TMDBEpisode {
        let endpoint = "tv/\(tvShowId)/season/\(seasonNumber)/episode/\(episodeNumber)"
        return try await performRequest(endpoint: endpoint, queryItems: [])
    }
        
    func fetchSimilarTVShows(id: Int, page: Int) async throws -> TMDBSearchResponse<TMDBTVShow> {
        let endpoint = "tv/\(id)/similar"
        let queryItems = [
            URLQueryItem(name: "page", value: String(page))
        ]
        return try await performRequest(endpoint: endpoint, queryItems: queryItems)
    }
    
    // MARK: - Discovery Methods
    
    func fetchTrending(mediaType: String, timeWindow: String) async throws -> TMDBSearchResponse<TMDBSearchResult> {
        let endpoint = "trending/\(mediaType)/\(timeWindow)"
        return try await performRequest(endpoint: endpoint, queryItems: [])
    }
    
    func fetchUpcomingMovies(page: Int) async throws -> TMDBSearchResponse<TMDBMovie> {
        let endpoint = "movie/upcoming"
        let queryItems = [
            URLQueryItem(name: "page", value: String(page))
        ]
        return try await performRequest(endpoint: endpoint, queryItems: queryItems)
    }
    
    func fetchOnTheAirTVShows(page: Int) async throws -> TMDBSearchResponse<TMDBTVShow> {
        let endpoint = "tv/on_the_air"
        let queryItems = [
            URLQueryItem(name: "page", value: String(page))
        ]
        return try await performRequest(endpoint: endpoint, queryItems: queryItems)
    }
}

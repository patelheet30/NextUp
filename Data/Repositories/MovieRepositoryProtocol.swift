//
//  MovieRepositoryProtocol.swift
//  NextUp
//
//  Created by Heet Patel on 16/12/2025.
//

import Foundation
import GRDB

protocol MovieRepositoryProtocol {
    
    // MARK: - Fetch Operations
    func fetchMovie(id: String) throws -> Movie?
    func fetchAllMovies() throws -> [Movie]
    func searchMovies(query: String) throws -> [Movie]
    
    // MARK: - Write Operations
    func saveMovie(_ movie: Movie) throws
    func saveMovies(_ movies: [Movie]) throws
    func deleteMovie(id: String) throws
    
    // MARK: - Cache Management
    func isMovieCached(id: String) throws -> Bool
    func getLastSynced(id: String) throws -> Date?
}

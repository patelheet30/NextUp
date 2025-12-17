//
//  TMDBError.swift
//  NextUp
//
//  Created by Heet Patel on 17/12/2025.
//

import Foundation

enum TMDBError: Error {
    case invalidURL
    case networkError(Error)
    case invalidResponse
    case httpError(statusCode: Int)
    case decodingError(Error)
    case rateLimitExceeded
}

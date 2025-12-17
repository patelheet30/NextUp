//
//  TMDBSearchResponse.swift
//  NextUp
//
//  Created by Heet Patel on 17/12/2025.
//

import Foundation

struct TMDBSearchResponse<T: Codable>: Codable {
    // MARK: Variables
    let page: Int
    let results: [T]
    let totalPages: Int
    let totalResults: Int
    
    // MARK: Coding Keys
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

//
//  TMDBGenre.swift
//  NextUp
//
//  Created by Heet Patel on 16/12/2025.
//

import Foundation

struct TMDBGenre: Codable {
    // MARK: Variables
    let id: Int
    let name: String
    
    // MARK: Convert TMDBGenre to Genre
    func toDomainModel() -> Genre {
        return Genre(id: id, name: name)
    }
}

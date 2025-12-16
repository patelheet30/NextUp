//
//  Episode.swift
//  NextUp
//
//  Created by Heet Patel on 16/12/2025.
//

import Foundation
import GRDB

struct Episode: Codable, FetchableRecord, PersistableRecord {
    let id: String
    let seasonId: String // foreign key
    let tvShowId: String // foreign key
    let episodeNumber: Int
    let seasonNumber: Int
    let name: String
    let overview: String?
    let stillPath: String?
    let airDate: Date?
    let runtime: Int?
    
    var episodeCode: String {
        String(format: "S%02dE%02d", seasonNumber, episodeNumber)
    }
}

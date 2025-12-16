//
//  Season.swift
//  NextUp
//
//  Created by Heet Patel on 16/12/2025.
//

import Foundation
import GRDB

struct Season: Codable, FetchableRecord, PersistableRecord {
    let id: String
    let seasonNumber: Int
    let tvShowId: String // Foreign Key
    let name: String
    let overview: String?
    let posterPath: String?
    let airDate: Date?
    let episodeCount: Int
}

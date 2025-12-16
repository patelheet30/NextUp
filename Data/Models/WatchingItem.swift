//
//  WatchingItem.swift
//  NextUp
//
//  Created by Heet Patel on 16/12/2025.
//

import Foundation
import GRDB

struct WatchingItem: Codable, FetchableRecord, PersistableRecord {
    let id: UUID // local primary key
    let mediaType: MediaType
    let movieId: String?
    let episodeId: String?
    let tvShowId: String
    let progress: Double
    let duration: Int
    let currentTime: Int
    let lastUpdated: Date
    let startedWatching: Date
    let status: WatchStatus
    let notes: String?
}

//
//  QueueItem.swift
//  NextUp
//
//  Created by Heet Patel on 16/12/2025.
//

import Foundation
import GRDB

struct QueueItem: Codable, FetchableRecord, PersistableRecord {
    let id: UUID
    let mediaType: MediaType
    let movieId: String?
    let episodeId: String?
    let tvShowId: String?
    let addedDate: Date
    let priority: Int
    let autoSuggested: Bool
}

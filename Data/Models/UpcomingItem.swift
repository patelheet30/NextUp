//
//  UpcomingItem.swift
//  NextUp
//
//  Created by Heet Patel on 16/12/2025.
//

import Foundation
import GRDB

struct UpcomingItem: Codable, FetchableRecord, PersistableRecord {
    let id: UUID
    let mediaType: MediaType
    let movieId: String?
    let seasonId: String?
    let tvShowId: String?
    let releaseDate: Date?
    let notificationEnabled: Bool
    let addedDate: Date
}

//
//  Genre.swift
//  NextUp
//
//  Created by Heet Patel on 16/12/2025.
//

import Foundation
import GRDB

struct Genre: Codable, FetchableRecord, PersistableRecord {
    let id: Int
    let name: String
}

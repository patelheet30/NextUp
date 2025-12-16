//
//  DatabaseManager.swift
//  NextUp
//
//  Created by Heet Patel on 16/12/2025.
//

import Foundation
import GRDB

enum DatabaseError: Error {
    case cannotFindDocumentsDirectory
    case migrationFailed
}

class DatabaseManager: DatabaseManagerProtocol {
    private let dbQueue: DatabaseQueue
    
    // MARK: Initialise DatabaseManager
    init() throws {
        let fileManager = FileManager.default
        let folder = try fileManager.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true
        )
        
        let dbURL = folder.appendingPathComponent(AppConfiguration.Database.name)
        
        self.dbQueue = try DatabaseQueue(path: dbURL.path())
        try setupDatabase()
    }
    
    func setupDatabase() throws {
        var migrator = DatabaseMigrator()
        
        // MARK: v1 Migration
        migrator.registerMigration("v1") { db in
            
            
            // MARK: Movies Table
            try db.create(table: "movies") { t in
                t.column("id", .text).primaryKey()
                t.column("title", .text).notNull()
                t.column("overview", .text)
                t.column("poster_path", .text)
                t.column("backdrop_path", .text)
                t.column("release_date", .date)
                t.column("runtime", .integer)
                t.column("genres", .text)
                t.column("tmdb_rating", .real)
                t.column("tmdb_vote_count", .integer)
                t.column("status", .text)
                t.column("original_language", .text)
                t.column("production_countries", .text)
                t.column("last_synced", .datetime)
            }
            
            // MARK: TV Shows Table
            try db.create(table: "tv_shows") { t in
                t.column("id", .text).primaryKey()
                t.column("title", .text).notNull()
                t.column("overview", .text)
                t.column("poster_path", .text)
                t.column("backdrop_path", .text)
                t.column("first_air_date", .date)
                t.column("last_air_date", .date)
                t.column("number_of_seasons", .integer)
                t.column("number_of_episodes", .integer)
                t.column("genres", .text)
                t.column("tmdb_rating", .real)
                t.column("tmdb_vote_count", .integer)
                t.column("status", .text)
                t.column("networks", .text)
                t.column("last_synced", .datetime)
            }
            
            // MARK: Seasons Table
            try db.create(table: "seasons") { t in
                t.column("id", .text).primaryKey()
                t.column("tv_show_id", .text).references("tv_shows")
                t.column("season_number", .integer)
                t.column("name", .text)
                t.column("overview", .text)
                t.column("poster_path", .text)
                t.column("air_date", .date)
                t.column("episode_count", .integer)
            }
            
            // MARK: Episodes Table
            try db.create(table: "episodes") { t in
                t.column("id", .text).primaryKey()
                t.column("season_id", .text).references("seasons")
                t.column("tv_show_id", .text).references("tv_shows")
                t.column("episode_number", .integer)
                t.column("season_number", .integer)
                t.column("name", .text)
                t.column("overview", .text)
                t.column("still_path", .text)
                t.column("air_date", .date)
                t.column("runtime", .integer)
            }
            
            // MARK: Watching Items Table
            try db.create(table: "watching_items") { t in
                t.column("id", .text).primaryKey()
                t.column("media_type", .text).notNull()
                t.column("movie_id", .text)
                t.column("episode_id", .text)
                t.column("tv_show_id", .text).notNull()
                t.column("progress", .real)
                t.column("duration", .integer)
                t.column("current_time", .integer)
                t.column("last_updated", .datetime)
                t.column("started_watching", .datetime)
                t.column("status", .text)
                t.column("notes", .text)
            }
            
            // MARK: Queue Items Table
            try db.create(table: "queue_items") { t in
                t.column("id", .text).primaryKey()
                t.column("media_type", .text).notNull()
                t.column("movie_id", .text)
                t.column("episode_id", .text)
                t.column("tv_show_id", .text)
                t.column("added_date", .datetime)
                t.column("priority", .integer)
                t.column("auto_suggested", .boolean)
            }
            
            // MARK: Upcoming Items Table
            try db.create(table: "upcoming_items") { t in
                t.column("id", .text).primaryKey()
                t.column("media_type", .text).notNull()
                t.column("movie_id", .text)
                t.column("season_id", .text)
                t.column("tv_show_id", .text)
                t.column("release_date", .datetime)
                t.column("notification_enabled", .boolean)
                t.column("added_date", .datetime)
            }
            
            // MARK: Genres Table
            try db.create(table: "genres") { t in
                t.column("id", .integer).primaryKey()
                t.column("name", .text).notNull()
            }
            
            // MARK: Image Cache Table
            try db.create(table: "image_cache") { t in
                t.column("url", .text).primaryKey()
                t.column("local_path", .text)
                t.column("download_date", .datetime)
                t.column("last_accessed", .datetime)
            }
            
            // MARK: Indexes
            try db.create(index: "idx_watching_items_show_id", on: "watching_items", columns: ["tv_show_id"])
            try db.create(index: "idx_watching_items_last_updated", on: "watching_items", columns: ["last_updated"])
            try db.create(index: "idx_queue_items_tv_show_id", on: "queue_items", columns: ["tv_show_id"])
            try db.create(index: "idx_queue_items_priority", on: "queue_items", columns: ["priority"])
            try db.create(index: "idx_queue_items_added_date", on: "queue_items", columns: ["added_date"])
            try db.create(index: "idx_upcoming_items_release_date", on: "upcoming_items", columns: ["release_date"])
            try db.create(index: "idx_episodes_tv_show_id", on: "episodes", columns: ["tv_show_id"])
            try db.create(index: "idx_episodes_season_episode", on: "episodes", columns: ["season_number", "episode_number"])
            try db.create(index: "idx_seasons_tv_show_id", on: "seasons", columns: ["tv_show_id"])
            try db.create(index: "idx_seasons_season_number", on: "seasons", columns: ["season_number"])
        }
        
        try migrator.migrate(dbQueue)
    }
    
    // MARK: Write operation
    // Execute a write operation.
    func write<T>(_ block: (Database) throws -> T) throws -> T {
        return try dbQueue.write(block)
    }
    
    // MARK: Read operation
    // Execute a read operation.
    func read<T>(_ block: (Database) throws -> T) throws -> T {
        return try dbQueue.read(block)
    }
}


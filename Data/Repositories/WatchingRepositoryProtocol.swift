//
//  WatchingRepositoryProtocol.swift
//  NextUp
//
//  Created by Heet Patel on 16/12/2025.
//

import Foundation

protocol WatchingRepositoryProtocol {
    
    // MARK: - Fetch Operations
    func fetchAllWatchingItems() throws -> [WatchingItem]
    func fetchWatchingItem(id: UUID) throws -> WatchingItem?
    func fetchWatchingItems(forTVShowId tvShowId: String) throws -> [WatchingItem]
    func fetchWatchingItems(status: WatchStatus) throws -> [WatchingItem]
    func fetchRecentWatchingItems(limit: Int) throws -> [WatchingItem]
    
    // MARK: - Write Operations
    func saveWatchingItem(_ item: WatchingItem) throws
    func updateProgress(id: UUID, progress: Double, currentTime: Int) throws
    func updateStatus(id: UUID, status: WatchStatus) throws
    func deleteWatchingItem(id: UUID) throws
    func deleteAllWatchingItems(forTVShowId tvShowId: String) throws
    
    // MARK: - Statistics
    func getTotalWatchingCount() throws -> Int
    func getWatchingCount(forTVShowId tvShowId: String) throws -> Int
}

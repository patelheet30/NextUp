//
//  UpcomingRepositoryProtocol.swift
//  NextUp
//
//  Created by Heet Patel on 16/12/2025.
//

import Foundation

protocol UpcomingRepositoryProtocol {
    
    // MARK: - Fetch Operations
    func fetchAllUpcomingItems() throws -> [UpcomingItem]
    func fetchUpcomingItem(id: UUID) throws -> UpcomingItem?
    func fetchUpcomingItems(releaseDateBefore date: Date) throws -> [UpcomingItem]
    func fetchUpcomingItems(releaseDateAfter date: Date) throws -> [UpcomingItem]
    func fetchUpcomingItemsWithoutDate() throws -> [UpcomingItem]
    func fetchUpcomingItems(mediaType: MediaType) throws -> [UpcomingItem]
    
    // MARK: - Write Operations
    func saveUpcomingItem(_ item: UpcomingItem) throws
    func updateNotificationStatus(id: UUID, enabled: Bool) throws
    func deleteUpcomingItem(id: UUID) throws
    
    // MARK: - Statistics
    func getUpcomingCount(within days: Int) throws -> Int
    func getTotalUpcomingCount() throws -> Int
}

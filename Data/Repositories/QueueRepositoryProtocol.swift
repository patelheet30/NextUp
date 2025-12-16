//
//  QueueRepositoryProtocol.swift
//  NextUp
//
//  Created by Heet Patel on 16/12/2025.
//

import Foundation

protocol QueueRepositoryProtocol {
    
    // MARK: - Fetch Operations
    func fetchAllQueueItems() throws -> [QueueItem]
    func fetchQueueItem(id: UUID) throws -> QueueItem?
    func fetchQueueItems(forTVShowId tvShowId: String) throws -> [QueueItem]
    func fetchAutoSuggestedItems() throws -> [QueueItem]
    func fetchManualQueueItems() throws -> [QueueItem]
    
    // MARK: - Write Operations
    func saveQueueItem(_ item: QueueItem) throws
    func updatePriority(id: UUID, priority: Int) throws
    func deleteQueueItem(id: UUID) throws
    func deleteAllQueueItems(forTVShowId tvShowId: String) throws
    
    // MARK: - Queue Management
    func getNextPriority() throws -> Int
    func reorderQueue(items: [(id: UUID, priority: Int)]) throws
    func getTotalQueueCount() throws -> Int
}

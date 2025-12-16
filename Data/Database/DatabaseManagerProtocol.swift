//
//  DatabaseManagerProtocol.swift
//  NextUp
//
//  Created by Heet Patel on 16/12/2025.
//

import Foundation
import GRDB

protocol DatabaseManagerProtocol {
    
    // MARK: Database setup
    // Setups the database connection runs migrations
    func setupDatabase() throws
    
    // MARK: Write operation
    // Execute a write operation.
    func write<T>(_ block: (Database) throws -> T) throws -> T
    
    // MARK: Read operation
    // Execute a read operation.
    func read<T>(_ block: (Database) throws -> T) throws -> T
}

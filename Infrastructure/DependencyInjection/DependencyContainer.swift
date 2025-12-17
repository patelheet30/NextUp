//
//  DependencyContainer.swift
//  NextUp
//
//  Created by Heet Patel on 16/12/2025.
//

class DependencyContainer {
    static let shared = DependencyContainer()
    
    lazy var tmdbService: TMDBServiceProtocol = {
        return TMDBService()
    }()
    
    lazy var imageService: TMDBImageService = {
        return TMDBImageService()
    }()
    
    private init() {
        
    }
    
    // MARK: - Core Services
    
    lazy var databaseManager: DatabaseManagerProtocol = {
        // For now, we release a compiler error
        fatalError("Database Manager not yet implemented")
    }()
    
    // MARK: - Repositories
    
    lazy var movieRepository: MovieRepositoryProtocol = {
        // rough implementation on how the repositories will depend on the databaseManager and tmdbService
        let db = self.databaseManager
        let api = self.tmdbService
        
        // return MovieRepository(database: db, tmdbService: api)
        
        fatalError("Movie Repository not yet implemented")
    }()
    
    lazy var tvShowRepository: TVShowRepositoryProtocol = {
        // rough implementation on how the repositories will depend on the databaseManager and tmdbService
        let db = self.databaseManager
        let api = self.tmdbService
        
        // return TvShowRepository(database: db, tmdbService: api)
        
        fatalError("TV Show Repository not yet implemented")
    }()
    
    lazy var watchingRepository: WatchingRepositoryProtocol = {
        // rough implementation on how the repositories will depend on the databaseManager
        let db = self.databaseManager
        
        // return WatchingRepository(database: db)
        
        fatalError("Watching Repository not yet implemented")
    }()
    
    lazy var queueRepository: QueueRepositoryProtocol = {
        // rough implementation on how the repositories will depend on the databaseManager
        let db = self.databaseManager
        
        // return QueueRepository(database: db)
        
        fatalError("Queue Repository not yet implemented")
    }()
    
    lazy var upcomingRepository: UpcomingRepositoryProtocol = {
        // rough implementation on how the repositories will depend on the databaseManager
        let db = self.databaseManager
        
        // return UpcomingRepository(database: db)
        
        fatalError("Upcoming Repository not yet implemented")
    }()
    
}

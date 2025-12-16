//
//  AppConfiguration.swift
//  NextUp
//
//  Created by Heet Patel on 16/12/2025.
//

import CoreFoundation

struct AppConfiguration {
    struct API {
        static let baseURL = "https://api.themoviedb.org/3/"
        static let apiKey = "..."
        static let imageBaseURL = "https://image.tmdb.org/t/p/"
        static let requestTimeout: TimeInterval = 30
        
        struct ImageSizes {
            static let posterSmall = "w185"
            static let posterMedium = "w500"
            static let backdropMedium = "w780"
            static let backdropLarge = "w1280"
            static let stillSmall = "w300"
            static let profileSmall = "w185"
            static let original = "original"
        }
        
        static let rateLimit: TimeInterval = 40
        
    }
    
    struct Database {
        static let name = "nextupstore"
        static let schemaVersion: Int = 1
    }
    
    struct Cache {
        static let memoryCacheLimit: Int = 150
        static let diskCacheLimit: Int = 500
        static let cacheExpiryDays: TimeInterval = 60 * 60 * 24 * 7
    }
    
    struct UI {
        static let cornerRadius: CGFloat = 16
        static let stackOffset: CGFloat = 8
        static let standardMargin: CGFloat = 20
        static let blockHeight: CGFloat = 120
        static let springDuration: CGFloat = 0.4
        static let springDamping: CGFloat = 0.7
        static let fadeInDuration: CGFloat = 0.3
        
    }

}

//
//  TMDBImageService.swift
//  NextUp
//
//  Created by Heet Patel on 17/12/2025.
//

import Foundation

class TMDBImageService {
    private let baseURL: String
    
    init() {
        self.baseURL = AppConfiguration.API.imageBaseURL
    }
    
    private func buildImageURL(path: String, size: String) -> URL? {
        let urlString = baseURL + size + path
        return URL(string: urlString)
    }
    
    // MARK: Image Requests
    func posterURL(path: String, size: String = AppConfiguration.API.ImageSizes.posterMedium) -> URL? {
        return buildImageURL(path: path, size: size)
    }
    
    func backdropURL(path: String, size: String = AppConfiguration.API.ImageSizes.backdropMedium) -> URL? {
        return buildImageURL(path: path, size: size)
    }
        
    func stillURL(path: String, size: String = AppConfiguration.API.ImageSizes.stillSmall) -> URL? {
        return buildImageURL(path: path, size: size)
    }
        
    func profileURL(path: String, size: String = AppConfiguration.API.ImageSizes.profileSmall) -> URL? {
        return buildImageURL(path: path, size: size)
    }
}

//
//  AppConfiguration.swift
//  GitHubProfilesApp
//
//  Created by Ashish Kheveria on 3/7/23.
//

import Foundation

struct AppConfiguration {
    
    // MARK: - App Configuration
    
    static let url = "https://api.github.com/"
        
    // MARK: - Initializer
    
    private init() { }
    
    // Mark: - Methods
    
    static func checkConfiguration() {
        if url.isEmpty {
            fatalError("Invalid configuration found.")
        }
    }
}

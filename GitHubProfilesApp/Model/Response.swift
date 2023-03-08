//
//  Response.swift
//  GitHubProfilesApp
//
//  Created by Ashish Kheveria on 3/7/23.
//

import Foundation

struct Response<T>: Decodable where T: Decodable {
    
    let totalCount: Int?
    
    let incompleteResults: Bool?
    
    let data: T
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case data = "items"
    }
}

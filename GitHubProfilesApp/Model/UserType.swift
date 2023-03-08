//
//  UserType.swift
//  GitHubProfilesApp
//
//  Created by Ashish Kheveria on 3/7/23.
//

import UIKit

enum UserType: String, Decodable {
    
    case user = "User"
    
    case organization = "Organization"
    
    var iconImage: UIImage {
        switch self {
        case .user:
           return  #imageLiteral(resourceName: "user")
        case .organization:
           return  #imageLiteral(resourceName: "organization")
        }
    }
}

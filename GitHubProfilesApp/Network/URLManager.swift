//
//  URLManager.swift
//  GitHubProfilesApp
//
//  Created by Ashish Kheveria on 3/7/23.
//

import Foundation

struct URLManager {
    
    // MARK: - Public Methods
    
    public static func getURLForEndpoint(_ endpoint: EndPoint,
                                         path: PathParameter? = nil,
                                         query: QueryParameter? = nil,
                                         pageNumber: UInt? = nil) -> URL? {
        
        let path = endpoint.updatePath(from: path ?? [:])       //create full path
        
        let url = AppConfiguration.url + path                      //Create full URL
        
        guard var urlComponents = URLComponents(string: url) else { return nil }
        
        var queryItems = endpoint.getMandatoryQueryItems(from: query ?? [:])    //Get mandatory query Items
        
        if let page = pageNumber {
            let pagingQueryItems = getPagingQueryItemsWithPage(page)        //Get paging Query Items, if any
            queryItems.append(contentsOf: pagingQueryItems)
        }
        
        urlComponents.queryItems = queryItems                   //Append Query Items
        
        return urlComponents.url                                //Return full URL.
    }
    
    // MARK: - Private Methods
    
    private static func getPagingQueryItemsWithPage(_ pageNumber: UInt?) -> [URLQueryItem] {
        
        guard let pageNumber = pageNumber else { return [] }
        
        let parameters = ["page"    : "\(pageNumber)"]
        
        let queryItems = parameters.map { URLQueryItem(name: $0, value: $1) }
        
        return queryItems
    }

}

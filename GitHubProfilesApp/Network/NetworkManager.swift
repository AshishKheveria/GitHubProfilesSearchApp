//
//  NetworkManager.swift
//  GitHubProfilesApp
//
//  Created by Ashish Kheveria on 3/7/23.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
}

class NetworkManager {
    
    // MARK: - Properties
    
    private var session: URLSession!
        
    // MARK: - Initializer
    
    init(session: URLSession = URLSession(configuration: .ephemeral)) {
        self.session = session
    }
    
    deinit {
        cancelAllTask()
    }
    
    // MARK: - Public Methods
    
    public func dataTaskFromURL<T: Decodable>(_ url: URL, completion: @escaping ((Result<T>) -> Void)) -> URLSessionDataTask {
        
        return session.dataTask(with: url, completionHandler: { (data, response, error) in
            
            if error == nil,
                let data = data {
                do {
                    let response = try Mapper.decoder.decode(T.self, from: data)
                    completion(.success(response))
                } catch let parsingError {
                    print(url, parsingError)
                    completion(.failure(parsingError))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        })
    }
    
    public func cancelAllTask() {
        session.invalidateAndCancel()
    }
}

//
//  StarWarsAPIClient.swift
//  theAPIAwakens
//
//  Created by Gavin Butler on 20-09-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import Foundation

class TheMovieDBAPIClient {
    
    let decoder = JSONDecoder()
    
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    func getTheMovieDBData<T: Codable>(with urlRequest: URLRequest, toType type: T.Type, completionHandler completion: @escaping (T?, Error?) -> Void) {
        
        let task = session.dataTask(with: urlRequest) { data, response, error in
            if let data = data {
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(nil, APIError.requestFailed)
                    return
                }
                if httpResponse.statusCode == 200 {
                    do {
                        let entity = try self.decoder.decode(type, from: data)
                        completion(entity, nil)
                        
                    } catch {
                        completion(nil, APIError.jsonParsingFailure)
                    }
                } else {
                    completion(nil, APIError.responseUnsuccessful(statusCode: httpResponse.statusCode))
                }
            } else if let error = error {
                completion(nil, APIError.noDataReturnedFromDataTask(detail: error.localizedDescription))
            }
        }
        
        task.resume()
    }
    
}

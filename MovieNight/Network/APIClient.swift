//
//  APIClient.swift
//  MovieNight
//
//  Created by Gavin Butler on 26-10-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import Foundation

protocol APIClient {
    var decoder: JSONDecoder { get }
    var session: URLSession { get }
}

extension APIClient {
    
    func fetchJSON<T: Codable>(with urlRequest: URLRequest, toType type: T.Type, completionHandler completion: @escaping (Result<T, APIError>) -> Void) {
        
        let task = session.dataTask(with: urlRequest) { data, response, error in
            if let data = data {
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(Result.failure(.requestFailed))  //Can’t capture the response
                    return
                }
                if httpResponse.statusCode == 200 {
                    do {
                        let entity = try self.decoder.decode(type, from: data)
                        completion(Result.success(entity))
                    } catch {
                        completion(Result.failure(.jsonParsingFailure)) //Successful http status code, have data but can’t parse to the model.
                    }
                } else {
                    //Try to capture TheMovieDB error message
                    do {
                        let entity = try self.decoder.decode(TheMovieDBErrorResponse.self, from: data)
                        print("TMDB Network Error: \(httpResponse.statusCode): \(entity.errorMessage)")
                    } catch {
                        completion(Result.failure(.responseUnsuccessful(statusCode: httpResponse.statusCode)))  //Failed to parse to the specified TMDB error model
                    }
                }
            } else if let error = error {
                completion(Result.failure(.noDataReturnedFromDataTask(detail: error.localizedDescription))) //No data returned from session data task
            }
        }
        
        task.resume()
    }
}

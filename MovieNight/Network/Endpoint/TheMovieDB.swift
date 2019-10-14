//
//  TheMovieDB.swift
//  MovieNight
//
//  Created by Gavin Butler on 13-10-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import Foundation

enum TheMovieDB {
    case discover(genre: String)
    
    //Takes a dictionary of parameter key/value pairs where the value is a string, and returns a URL query string.
    //With format key=value&nextKey=nextValue etc.
    func encodeParametersForURL(_ parameters: [ParameterKey : String]) -> String {
        
        var parametersAsStrings = [(String, String)]()
        
        for key in parameters.keys {
            let percentEncodedParameter =  parameters[key]!.percentEncoded()
            parametersAsStrings.append((key.rawValue, percentEncodedParameter))
        }
        
        let encodedParameters = parametersAsStrings.map { "\($0)=\($1)" }
        return encodedParameters.joined(separator: "&")
        
    }
}

extension TheMovieDB: Endpoint {
    var path: String {
        switch self {
        case .discover: return "/discover"
        }
    }
    
    var queryParameters: [URLQueryItem] {
        switch self {
        case .discover(let genre):
            var result = [URLQueryItem]()
            
            let genre = URLQueryItem(name: ParameterKey.genre.rawValue, value: genre)
            result.append(genre)
            
            return result
        }
    }
    
    var base: String {
        return "https://api.themoviedb.org/3"
    }
}

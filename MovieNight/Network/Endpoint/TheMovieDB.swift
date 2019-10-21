//
//  TheMovieDB.swift
//  MovieNight
//
//  Created by Gavin Butler on 13-10-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import Foundation

enum TheMovieDB {
    case discover(genres: String, certifications: String)
    case genreList
    case certificationList
    case actorList
}

extension TheMovieDB: Endpoint {
    var path: String {
        switch self {
        case .discover: return "/3/discover/movie"
        case .genreList: return "/3/genre/movie/list"
        case .certificationList: return "/3/certification/movie/list"
        case .actorList: return "/3/person/popular"
        }
    }
    
    var queryParameters: [URLQueryItem] {
        
        var result = [URLQueryItem]()
        
        //Set common query items
        result.append(URLQueryItem(name: ParameterKey.api_key.rawValue, value: "77bed8fca392b4795936215c684e2e95"))
        
        switch self {
        case .discover(let genres, let certifications):
            let genre = URLQueryItem(name: ParameterKey.genres.rawValue, value: genres)
            let certifications = URLQueryItem(name: ParameterKey.certifications.rawValue, value: certifications)
            result.append(genre)
        case .genreList:
            result.append(URLQueryItem(name: ParameterKey.language.rawValue, value: "en-US"))
        case .certificationList:
            result.append(URLQueryItem(name: ParameterKey.certificationCountry.rawValue, value: "CA"))
            break
        case .actorList:
            break
        }
        
        return result
    }
    
    var base: String {
        return "https://api.themoviedb.org"
    }
}

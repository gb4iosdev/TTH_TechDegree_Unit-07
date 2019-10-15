//
//  DataType.swift
//  MovieNight
//
//  Created by Gavin Butler on 14-10-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import Foundation

enum DataType: Int {
    case genre
    case certification
    case actor
    
    func endpoint() -> TheMovieDB {
        switch self {
        case .genre: return .genreList
        case .certification: return .genreList
        case .actor: return .actorList
        }
    }
    
    func listType() -> ListType.Type {
        switch self {
        case .genre: return Genres.self
        case .certification: return Genres.self
        case .actor: return Actors.self
        }
    }
}

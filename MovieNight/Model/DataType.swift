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
    
    var endPoint: TheMovieDB {
        switch self {
        case .genre: return .genreList
        case .certification: return .certificationList
        case .actor: return .actorList
        }
    }
    
    //Returns the next type - To assist with view controller transitions.
    var nextType: DataType {
        switch self {
        case .genre:            return .certification
        case .certification:    return .actor
        case .actor:            return .genre   //Should never execute
        }
    }

}

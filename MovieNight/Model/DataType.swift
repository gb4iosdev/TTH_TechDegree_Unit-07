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
    
    //Return the endpoint associated with the data type
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
    
    //Maximum number of items the user can select
    var maxSelections: Int {
        switch self {
        case .genre: return 5
        case .actor: return 5
        default: return -1              //Doesn’t apply to certifications
        }
    }
    
    //For View Controller titles
    func title() -> String {
        switch self {
        case .genre: return "Select up to 5 Genres"
        case .certification: return "Select Preferred Max Rating"
        case .actor: return "Select up to 5 Actors"
        }
    }
    

}

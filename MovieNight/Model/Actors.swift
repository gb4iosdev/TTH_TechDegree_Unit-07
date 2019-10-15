//
//  Actors.swift
//  MovieNight
//
//  Created by Gavin Butler on 14-10-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import Foundation

struct Actors: Codable, ListType {
    var actors: [Entity]
    
    enum CodingKeys: String, CodingKey {
        case actors = "results"
    }
}

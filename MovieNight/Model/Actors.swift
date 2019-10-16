//
//  Actors.swift
//  MovieNight
//
//  Created by Gavin Butler on 14-10-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import Foundation

struct Actors: Codable {
    var results: [Entity]
    
    enum CodingKeys: String, CodingKey {
        case results
    }
}

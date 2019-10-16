//
//  Genre.swift
//  MovieNight
//
//  Created by Gavin Butler on 12-10-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import Foundation

struct Genres: Codable {
    var results: [Entity] = []
    
    enum CodingKeys: String, CodingKey {
        case results = "genres"
    }
}

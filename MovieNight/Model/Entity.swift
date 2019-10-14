//
//  Entity.swift
//  MovieNight
//
//  Created by Gavin Butler on 13-10-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import Foundation

struct Entity: Codable {
    let name:       String
    let id:         Int
    //let dataType:   ParameterKey
    
    enum CodingKeys: String, CodingKey {
        case name
        case id
    }
}

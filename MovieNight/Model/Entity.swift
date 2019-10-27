//
//  Entity.swift
//  MovieNight
//
//  Created by Gavin Butler on 13-10-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import Foundation

//Model to capture a single general entity from Network fetch where only name and ID is required.
struct Entity: Codable {
    let name:       String
    let id:         Int
    
    enum CodingKeys: String, CodingKey {
        case name
        case id
    }
}

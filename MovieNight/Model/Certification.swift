//
//  CertificationEntity.swift
//  MovieNight
//
//  Created by Gavin Butler on 18-10-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import Foundation

//Model to capture a single Certification from Network fetch
struct Certification: Codable {
    let name:       String
    let order:         Int  //Used to sort by certification
    
    enum CodingKeys: String, CodingKey {
        case name = "certification"
        case order
    }
}


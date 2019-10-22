//
//  CertificationEntity.swift
//  MovieNight
//
//  Created by Gavin Butler on 18-10-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import Foundation

struct CertificationEntity: Codable {
    let name:       String
    let order:         Int
    //let dataType:   ParameterKey
    
    enum CodingKeys: String, CodingKey {
        case name = "certification"
        case order
    }
}


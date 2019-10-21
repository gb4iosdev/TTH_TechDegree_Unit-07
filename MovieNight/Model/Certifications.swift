//
//  Certifications.swift
//  MovieNight
//
//  Created by Gavin Butler on 17-10-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import Foundation

//struct Certifications: Codable {
//    var results: [Entity] = []
//
//    enum CodingKeys: String, CodingKey {
//        case results
//    }
//}

struct Certifications: Codable {
    var results: CertificationList
    
    enum CodingKeys: String, CodingKey {
        case results = "certifications"
    }
    
    struct CertificationList: Codable {
        var results: [CertificationEntity]
        
        enum CodingKeys: String, CodingKey {
            case results = "CA"
        }
    }
}



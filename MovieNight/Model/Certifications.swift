//
//  Certifications.swift
//  MovieNight
//
//  Created by Gavin Butler on 17-10-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import Foundation

//Model to capture List of certifications from Network fetch.
//Note that the final certification array is captured in the embedded CertificationList type.
struct Certifications: Codable {
    var results: CertificationList
    
    enum CodingKeys: String, CodingKey {
        case results = "certifications"
    }
    
    struct CertificationList: Codable {
        var results: [Certification]
        
        enum CodingKeys: String, CodingKey {
            case results = "CA"
        }
    }
}



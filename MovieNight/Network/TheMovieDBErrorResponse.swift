//
//  TheMovieDBErrorResponse.swift
//  MovieNight
//
//  Created by Gavin Butler on 24-10-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import Foundation

//Specified TMDB error model returned when HTTP Status code != 200
struct TheMovieDBErrorResponse: Codable {
    let code: Int
    let errorMessage: String
    
    enum CodingKeys: String, CodingKey {
        case code = "status_code"
        case errorMessage = "status_message"
    }
}

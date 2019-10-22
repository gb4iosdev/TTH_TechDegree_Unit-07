//
//  ParameterKey.swift
//  MovieNight
//
//  Created by Gavin Butler on 13-10-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import Foundation

//List of parameter keys that can be used in this application, and their query string representations.
enum ParameterKey: String {
    case genres = "with_genres"
    case certifications = "certification.lte"
    case certificationCountry = "certification_country"
    case actors
    case api_key
    case language
    case page
    case sortBy = "sort_by"
}

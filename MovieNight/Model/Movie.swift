//
//  Movie.swift
//  MovieNight
//
//  Created by Gavin Butler on 22-10-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import Foundation

import UIKit

class Movie:Codable {
    var title: String
    var overview: String
//    var artworkId: String
    var artwork: UIImage?
    var artworkState: MovieArtworkDownloadState = .placeholder
    
    init(title: String, overview: String, artworkId: String) {
    self.title = title
    self.overview = overview
//    self.artworkId = artworkId
    }
    
    enum CodingKeys: String, CodingKey {
        case title
        case overview
//        case artworkId
    }
}

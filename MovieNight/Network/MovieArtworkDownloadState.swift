//
//  MovieArtworkDownloadState.swift
//  MovieNight
//
//  Created by Gavin Butler on 22-10-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import Foundation

//Capture download state to avoid duplicate fetching
enum MovieArtworkDownloadState {
    case placeholder
    case downloaded
    case failed
}

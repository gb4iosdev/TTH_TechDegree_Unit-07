//
//  PendingOperations.swift
//  MovieNight
//
//  Created by Gavin Butler on 22-10-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import Foundation

class PendingOperations {
    
    var downloadsInProgress = [IndexPath : Operation]()
    let downloadQueue = OperationQueue()
}

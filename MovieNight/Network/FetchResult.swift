//
//  FetchResult.swift
//  MovieNight
//
//  Created by Gavin Butler on 26-10-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import Foundation

enum FetchResult<T, U> where U:Error {
    case success(T)
    case failure(U)
}

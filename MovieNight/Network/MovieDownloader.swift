//
//  MovieDownloader.swift
//  MovieNight
//
//  Created by Gavin Butler on 22-10-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import Foundation
import UIKit

class MovieDownloader: Operation {
    //Download movie cover artwork and assign it back to the Movie instance
    
    let movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
        super.init()
    }
    
    override func main() {
        //Check to see if the operation has been cancelled
        if self.isCancelled {
            return
        }
        
        //Download artwork associated with the movie.
        guard let url = TheMovieDB.image(imageId: movie.artworkId).request.url else { return }
        
        guard let imageData = try? Data(contentsOf: url) else { return }
        
        if self.isCancelled {
            return
        }
        
        if imageData.count > 0 {    ///Assume data is valid
            movie.artwork = UIImage(data: imageData)
            movie.artworkState = .downloaded
            //print("movie.artworkState for movie title: \( movie.title) is: \( movie.artworkState)")
        } else {
            movie.artworkState = .failed
        }
    }
}

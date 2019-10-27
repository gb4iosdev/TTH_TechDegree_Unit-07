//
//  MovieDetailViewController.swift
//  MovieNight
//
//  Created by Gavin Butler on 23-10-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    var movie: Movie?
    //Outlet Variables
    @IBOutlet weak var artworkImageView: UIImageView!
    @IBOutlet weak var movieOverviewLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let movie = movie else {
            print("Error: movie not initialized for View Controller")
            return
        }
        
        //If movie is assigned update the UI using the movie properties.
        artworkImageView.image = movie.artwork
        movieOverviewLabel.text = movie.overview
        self.title = movie.title
        
    }


}

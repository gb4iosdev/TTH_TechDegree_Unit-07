//
//  ResultsDataSource.swift
//  MovieNight
//
//  Created by Gavin Butler on 22-10-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import UIKit

class ResultsDataSource: NSObject, UITableViewDataSource {
    
    private var movies: [Movie]
    let pendingOperations = PendingOperations()
    let tableView: UITableView
    
    //Initialize with set of movies and with reference to the table view linked to this data source.
    init(movies: [Movie], tableView: UITableView) {
        self.movies = movies
        self.tableView = tableView
        super.init()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let movieCell = tableView.dequeueReusableCell(withIdentifier: MovieCell.reuseIdentifier) as? MovieCell else {
            
            print("Error:  Failed to initialize Movie Cell")
            return UITableViewCell()
        }
        
        let movie = movies[indexPath.row]
        movieCell.title.text = movie.title
        movieCell.subTitle.text = movie.overview
        
        if movie.artworkState == .downloaded {  //If move artwork has already been downloaded, use that
            movieCell.artwork.image = movie.artwork!
            movieCell.artwork.alpha = 1.0
        } else {    //Otherwise set the default image for the immediate rendering
            movieCell.artwork.image = UIImage(named: "iTunesArtwork")!
        }
        
        //if Artwork state is placeholder, attempt a download:
        if movie.artworkState == .placeholder {
            downloadArtworkForMovie(movie, at: indexPath)
        }
        
        return movieCell
    }
    
    //MARK: - Helper Methods:
    
    func movie(at indexPath: IndexPath) -> Movie {
        return movies[indexPath.row]
    }
    
    func append(movies: [Movie]) {
        self.movies.append(contentsOf: movies)
    }
    
    func movieCount() -> Int {
        return movies.count
    }
    
    func downloadArtworkForMovie (_ movie: Movie, at indexPath: IndexPath) {
        
        //Don’t do anything if this download is already in progress.
        if let _ = pendingOperations.downloadsInProgress[indexPath] {
            return
        }
        
        //Otherwise instantiate a MovieDownloader operation, set it’s completion handler, register the operation in the tracker dictionary (downloadsInProgress), and add it to the queue for execution.
        let downloader = MovieDownloader(movie: movie)
        
        downloader.completionBlock = {
            if downloader.isCancelled {
                return
            }
            
            DispatchQueue.main.async {
                self.pendingOperations.downloadsInProgress.removeValue(forKey: indexPath)
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
        
        pendingOperations.downloadsInProgress[indexPath] = downloader
        pendingOperations.downloadQueue.addOperation(downloader)
    }

    
}

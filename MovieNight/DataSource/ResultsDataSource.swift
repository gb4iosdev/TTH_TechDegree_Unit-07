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
        movieCell.accessoryType = .disclosureIndicator
        
        movieCell.artwork.image = movie.artworkState == .downloaded ? movie.artwork! : UIImage(named: "iTunesArtwork")!
        
        if movie.artworkState == .placeholder {
            downloadArtworkForMovie(movie, at: indexPath)
        }
        
        return movieCell
    }
    
    //MARK: - Helper Methods:
    
    func movie(at indexPath: IndexPath) -> Movie {
        return movies[indexPath.row]
    }
    
    func update(with movies: [Movie]) {
        self.movies = movies
    }
    
    func append(movies: [Movie]) {
        self.movies.append(contentsOf: movies)
    }
    
    func downloadArtworkForMovie (_ movie: Movie, at indexPath: IndexPath) {
        if let _ = pendingOperations.downloadsInProgress[indexPath] {
            return
        }
        
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

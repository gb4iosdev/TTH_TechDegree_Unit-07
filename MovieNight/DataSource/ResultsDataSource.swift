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
        guard let movieCell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") else { return UITableViewCell() }
        //let movie = movie(at: indexPath)
        //movieCell.title = movie.name
        //movieCell.subTitle = movie.longDescription
        //movieCell.accessoryType = .disclosureIndicator
        
        movieCell.textLabel?.text = movies[indexPath.row].title
        
        //movieCell.artwork = movie.artworkState == .downloaded ? movie.artwork! : UIImage(named: "MovieImagePlaceholder")!
        
        //        if movie.artworkState == .placeholder {
        //            downloadArtworkForMovie(movie, atIndexPath: indexPath)
        //        }
        
        return movieCell
    }
    
    //MARK: - Helper Methods:
    
    func movie(at indexPath: IndexPath) -> Movie {
        return movies[indexPath.row]
    }
    
    func update(with movies: [Movie]) {
        self.movies = movies
    }

    
}

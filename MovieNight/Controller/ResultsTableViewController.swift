//
//  ResultsTableViewController.swift
//  MovieNight
//
//  Created by Gavin Butler on 19-10-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import UIKit

class ResultsTableViewController: UITableViewController {
    
    var endpoint: Endpoint?
    let client = TheMovieDBAPIClient()
    let moviePageLimit = 10
    
    lazy var dataSource: ResultsDataSource = {
        return ResultsDataSource(movies: [], tableView: self.tableView)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let endpoint = self.endpoint else {
            print("Error: Endpoint not initialized")
            return
        }
        
        tableView.dataSource = dataSource
        
        print(endpoint.request)
        
        fetchMovies(at: endpoint, page: 1)
        
        self.title = "Recommendations"
        
    }
}

//MARK: - Networking
extension ResultsTableViewController {
    
    func fetchMovies(at endpoint: Endpoint, page: Int) {
        client.getTheMovieDBData(with: endpoint.requestForPage(page), toType: Movies.self) { [weak self] entities, error in
            
            if let entities = entities {
                //Add results to dataSource
                self?.dataSource.append(movies: entities.results)
                
                //Check if this is the last page to fetch
                if let pageLimit = self?.moviePageLimit, page < min(entities.totalPages, pageLimit) {
                    self?.fetchMovies(at: endpoint, page: page + 1)
                } else {                   //Have added the last page of data.  Refresh tableView
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                }
            } else {
                print("Error is: \(String(describing: error))")
            }
        }
        
    }
}


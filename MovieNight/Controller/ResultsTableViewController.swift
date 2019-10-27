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
    let moviePageLimit = 10     //Constrains the network fetch to this many pages
    
    //TableView DataSource initialization (lazy)
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
        
        //print(endpoint.request)
        
        //Network fetch movies, starting at first page
        fetchMovies(at: endpoint, page: 1)
        
        //Set navbar title
        self.title = "Recommendations"
        
    }
}

//MARK: - Delegate Methods
extension ResultsTableViewController {
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return Attribution.view
    }
}

//MARK: - Helper Methods
extension ResultsTableViewController {
    
    func alertUser(withTitle title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        
        present(alertController, animated: true, completion: nil)
    }
}

//MARK: - Networking
extension ResultsTableViewController {
    
    func fetchMovies(at endpoint: Endpoint, page: Int) {
        client.fetchJSON(with: endpoint.requestForPage(page), toType: Movies.self) { [weak self] result in
            switch result {
            case .success(let results):
                //Add results to dataSource:
                self?.dataSource.append(movies: results.results)
                //Check if this is the last page to fetch, otherwise fetch next page
                if let pageLimit = self?.moviePageLimit, page < min(results.totalPages, pageLimit) {
                    self?.fetchMovies(at: endpoint, page: page + 1)
                } else {                   //Have added the last page of data.  Alert user if no results - otherwise Refresh tableView
                    if self?.dataSource.movieCount() == 0 {
                        self?.alertUser(withTitle: "No Movies Found", message: "The selections did not return any movies.  Please reselect")
                    } else {
                        DispatchQueue.main.async {
                            self?.tableView.reloadData()
                        }
                    }
                }
            case .failure(let error):
                print("Error is: \(String(describing: error))")
            }
        }
    }
}

//MARK: - Segues
extension ResultsTableViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard segue.identifier == "MovieDetailSegue" else {
            print("Error:  Segue Identifier not recognized")
            return
        }
        
        guard let indexPath = tableView.indexPathForSelectedRow, let movieDetailController = segue.destination as? MovieDetailViewController else {
            print("Error:  Cannot cast segue destination as Movie Detail view controller")
            return
        }
        
        //Set the movie on the destination detail view controller in accordance with selected cell:
        movieDetailController.movie = dataSource.movie(at: indexPath)
    }
}



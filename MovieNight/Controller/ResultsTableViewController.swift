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
    
    lazy var dataSource: ResultsDataSource = {
        return ResultsDataSource(movies: [], tableView: self.tableView)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let endPoint = endpoint else {
            print("Error: Endpoint not initialized")
            return
        }
        
        tableView.dataSource = dataSource
        
        print(endPoint.request)
        
        client.getTheMovieDBData(with: endPoint.request, toType: Movies.self) { [unowned self] entities, error in
            if let entities = entities {
                DispatchQueue.main.async {
                    //self.tempDataSource = entities.results
                    print("entities count is: \(entities.results.count)")
                    print("entities are: \(entities.results.map{$0.title})")
                    print("totalpages: \(entities.totalPages)")
                    self.dataSource.update(with: entities.results)
                    self.tableView.reloadData()
                }
            } else {
                print("Error is: \(String(describing: error))")
            }
        }
        
    }
}

//
//  ListTableViewController.swift
//  MovieNight
//
//  Created by Gavin Butler on 14-10-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import UIKit

class ListTableViewController<T: Codable>: UITableViewController {
    
    var dataType: DataType?
    var allEntities: T?
    var results: [Entity] = []
    let client = TheMovieDBAPIClient()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let dataType = dataType else {
            print("Error: Entity for TheMovieDB API not initialized")
            return
        }
        print("Got into view did load")
        
        if let _ = allEntities as? Genres {
            print("We have Genres")
        } else if let _ = allEntities as? Actors {
            print("We have Actors")
        } else {
            print("We have an unknown type")
        }
        
        let endPoint = dataType.endpoint()
        //print(endPoint.request)
        
        /*client.getTheMovieDBData(with: endPoint.request, toType: allEntities.self) { [weak self] entities, error in
            if let entities = entities {
                self?.results = entities.results    //Setting the tableView datasource
                DispatchQueue.main.async {
                    self!.tableView.reloadData()
                }
            } else {
                print("Error is: \(String(describing: error))")
            }
        }*/
        
        
        //let selectedIndexPaths = tableView.indexPathsForSelectedRows
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //guard let dataType = self.dataType else { return tableView.dequeueReusableCell(withIdentifier: "TMDBListCell")! }
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TMDBListCell"), let textLabel = cell.textLabel {
            textLabel.text = results[indexPath.row].name
            return cell
        } else {
            print("Error: failed to generate custom TMDBListCell cell")
            return UITableViewCell()
        }
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedIndexPaths = tableView.indexPathsForSelectedRows else { return }
        for indexPath in selectedIndexPaths {
            print(results[indexPath.row])
        }
    }
    
    //MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //Get the destination view controller - only if the right type
        guard let nextListController = segue.destination as? ListTableViewController<Actors> else {
            print("Error:  Attempted segue not registered")
            return
        }
        
        //Set the selected character on the PilotedCraft Controller to allow piloted craft detail to be retried & displayed.
        nextListController.dataType = DataType(rawValue: self.dataType!.rawValue + 1)!
    }
}

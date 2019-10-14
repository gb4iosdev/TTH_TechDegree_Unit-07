//
//  ListTableViewController.swift
//  MovieNight
//
//  Created by Gavin Butler on 14-10-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {
    
    var dataType: ParameterKey?
    var genres: [Entity] = []
    let client = TheMovieDBAPIClient()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        client.getTheMovieDBData(from: URL(string: "https://api.themoviedb.org/3/genre/movie/list?api_key=77bed8fca392b4795936215c684e2e95&language=en-US"), toType: Genres.self) { [unowned self] entities, error in
            if let entities = entities {
                self.genres = entities.genres
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                print("Error is: \(String(describing: error))")
            }

        
            
        }
        
        //let selectedIndexPaths = tableView.indexPathsForSelectedRows
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
}

// MARK: - Table view data source & delegate

extension ListTableViewController {

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return genres.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TMDBListCell"), let textLabel = cell.textLabel {
            textLabel.text = genres[indexPath.row].name
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
            print(genres[indexPath.row])
        }
    }
}

//MARK: - Segues
extension ListTableViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //Get the destination view controller - only if the right type
        guard let genreController = segue.destination as? ListTableViewController else {
            print("Error:  Attempted segue not registered")
            return
        }
        
        //Set the selected character on the PilotedCraft Controller to allow piloted craft detail to be retried & displayed.
        genreController.dataType = .genre
    }
    
}

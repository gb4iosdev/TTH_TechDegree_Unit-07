//
//  ListTableViewController.swift
//  MovieNight
//
//  Created by Gavin Butler on 14-10-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {
    
    var dataType: DataType?
    var genres: [Entity] = []
    var actors: [Entity] = []
    let client = TheMovieDBAPIClient()
    var dataTypeType: ListType.Type?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let dataType = dataType else {
            print("Error: Entity for TheMovieDB API not initialized")
            return
        }
        
        switch dataType {
        case .genre: dataTypeType = Genres.self
        case .certification: dataTypeType = Genres.self
        case .actor: dataTypeType = Actors.self
        }
        
        let endPoint = dataType.endpoint()
        print(endPoint.request)
        switch dataType {
        case .genre, .certification:
            client.getTheMovieDBData(with: endPoint.request, toType: Genres.self) { [unowned self] entities, error in
                if let entities = entities {
                    self.genres = entities.genres
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } else {
                    print("Error is: \(String(describing: error))")
                }
            }
        case .actor:
            client.getTheMovieDBData(with: endPoint.request, toType: Actors.self) { [unowned self] entities, error in
                if let entities = entities {
                    self.actors = entities.actors
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } else {
                    print("Error is: \(String(describing: error))")
                }
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
        //
        guard let dataType = self.dataType else { return 0 }
        
        switch dataType {
        case .genre: return genres.count
        case .certification: return genres.count
        case .actor: return actors.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let dataType = self.dataType else { return tableView.dequeueReusableCell(withIdentifier: "TMDBListCell")! }
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TMDBListCell"), let textLabel = cell.textLabel {
            switch dataType {
            case .genre: textLabel.text = genres[indexPath.row].name
            case .certification: textLabel.text = genres[indexPath.row].name
            case .actor: textLabel.text = actors[indexPath.row].name
            }
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
        genreController.dataType = DataType(rawValue: self.dataType!.rawValue + 1)
    }
    
}

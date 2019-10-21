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
    var user: User?
    var genres: [Entity] = []
    var certifications: [CertificationEntity] = []
    var actors: [Entity] = []
    let client = TheMovieDBAPIClient()

    @IBOutlet weak var nextBarButtonItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let dataType = dataType else {
            print("Error: Entity for TheMovieDB API not initialized")
            return
        }
        
        guard let _ = user else {
            print("Error: User not initialized")
            return
        }
        
        fetch(for: dataType)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TMDBListCell")
        
    }
    
    @IBAction func navBarNextPressed(_ sender: UIBarButtonItem) {
        
        //
        guard let currentViewController = navigationController?.topViewController as? ListTableViewController, let currentType = currentViewController.dataType else { return }
        
        guard let selectedIndexPaths = currentViewController.tableView.indexPathsForSelectedRows, let user = currentViewController.user else { return }
        print("selectedIndexPaths are: \(selectedIndexPaths)")
        
        switch currentType {      //Save selected entities and Transition to next view controller
        case .actor:    // Save actors and Exit back to main screen
            var selectedActors: [Int] = []
            for row in selectedIndexPaths.map({ $0.row }) {
                selectedActors.append(currentViewController.actors[row].id)
            }
            UserSelection.update(for: user, actors: selectedActors)
            
            UserSelection.setUserDone(user)
            self.navigationController?.popToRootViewController(animated: true)
            return
        case .genre:
            //Save selected entities
            var selectedGenres: [Int] = []
            for row in selectedIndexPaths.map({ $0.row }) {
                selectedGenres.append(currentViewController.genres[row].id)
            }
            UserSelection.update(for: user, genres: selectedGenres)
        case .certification:
            //Save selected entities
            var selectedCertifications: [String] = []
            for row in selectedIndexPaths.map({ $0.row }) {
                selectedCertifications.append(currentViewController.certifications[row].certification)
            }
            UserSelection.update(for: user, certifications: selectedCertifications)
        }
        
        //Create and configure next TableViewController
        let nextViewController = ListTableViewController()
        nextViewController.dataType = currentViewController.dataType?.nextType
        nextViewController.user = currentViewController.user
        nextViewController.navigationItem.rightBarButtonItem = nextBarButtonItem
        nextViewController.tableView.allowsMultipleSelection = true
        
        //Push onto Navigation stack
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
  
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let dataType = self.dataType else { return 0 }
        
        switch dataType {
        case .genre: return genres.count
        case .certification: return certifications.count
        case .actor: return actors.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let dataType = self.dataType else { return tableView.dequeueReusableCell(withIdentifier: "TMDBListCell")! }
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TMDBListCell"), let textLabel = cell.textLabel {
            switch dataType {
            case .genre: textLabel.text = genres[indexPath.row].name
            case .certification: textLabel.text = certifications[indexPath.row].certification
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
        
    }
    
    
}

//MARK: - Networking
extension ListTableViewController {
    
    func fetch(for dataType: DataType) {
        switch dataType {
        case .genre:
            client.getTheMovieDBData(with: dataType.endPoint.request, toType: Genres.self) { [unowned self] entities, error in
                if let entities = entities {
                    if let currentViewController = self.navigationController?.topViewController as? ListTableViewController {
                        currentViewController.genres = entities.results
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } else {
                    print("Error is: \(String(describing: error))")
                }
            }
        case .certification:
            client.getTheMovieDBData(with: dataType.endPoint.request, toType: Certifications.self) { [unowned self] entities, error in
                if let entities = entities {
                    if let currentViewController = self.navigationController?.topViewController as? ListTableViewController {
                        currentViewController.certifications = entities.results.results
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } else {
                    print("Error is: \(String(describing: error))")
                }
            }
        case .actor:
            client.getTheMovieDBData(with: dataType.endPoint.request, toType: Actors.self) { [unowned self] entities, error in
                if let entities = entities {
                    if let currentViewController = self.navigationController?.topViewController as? ListTableViewController {
                        currentViewController.actors = entities.results
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } else {
                    print("Error is: \(String(describing: error))")
                }
            }
        }
    }
}

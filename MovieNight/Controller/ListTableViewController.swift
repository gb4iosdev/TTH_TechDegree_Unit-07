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
        
        initializeUI(for: dataType)
        
        fetch(for: dataType)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TMDBListCell")
        //tableView.register(UITableViewCell.self, forCellReuseIdentifier: "AttributionHeaderCell")
        
    }
    
    @IBAction func navBarNextPressed(_ sender: UIBarButtonItem) {
        
        //Ensure we can access the active view controller, and have a datatype and user specified:
        guard let currentViewController = navigationController?.topViewController as? ListTableViewController, let currentType = currentViewController.dataType, let user = currentViewController.user else { return }
        
        guard let selectedIndexPaths = currentViewController.tableView.indexPathsForSelectedRows else {                //Proceed if no items selected
            if currentType == .actor {
                UserSelection.setUserDone(user)
                self.navigationController?.popToRootViewController(animated: true)
            } else {
                showNextController(after: currentType)
            }
            return
        }
        
        print("selectedIndexPaths are: \(selectedIndexPaths)")

        
        switch currentType {      //Save selected entities and Transition to next view controller
        
        case .genre:
            //Check that max selections are not exceeded
            if selectedIndexPaths.count > currentType.maxSelections {
                alertUser(withTitle: "Too many Genres selected", message: "Please select a maximum of 5 Genres")
            } else {
                //Save selected entities
                var selectedGenres: [Int] = []
                for row in selectedIndexPaths.map({ $0.row }) {
                    selectedGenres.append(currentViewController.genres[row].id)
                }
                UserSelection.update(for: user, genres: selectedGenres)
                showNextController(after: currentType)
            }
            
        case .certification:
            //Save selection – should only be one
            var selectedCertification: CertificationEntity
            
            selectedCertification = currentViewController.certifications[selectedIndexPaths[0].row]
            UserSelection.update(for: user, certification: selectedCertification)
            showNextController(after: currentType)
        case .actor:    // Save actors and Exit back to main screen
            //Check that max selections are not exceeded
            if selectedIndexPaths.count > currentType.maxSelections {
                alertUser(withTitle: "Too many Actors selected", message: "Please select a maximum of 5 Actors")
            } else {
                var selectedActors: [Int] = []
                for row in selectedIndexPaths.map({ $0.row }) {
                    selectedActors.append(currentViewController.actors[row].id)
                }
                UserSelection.update(for: user, actors: selectedActors)
                
                UserSelection.setUserDone(user)
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
    
    func showNextController(after currentType: DataType) {
        
        guard let currentViewController = navigationController?.topViewController as? ListTableViewController else { return }
        
        //Create and configure next TableViewController
        let nextViewController = ListTableViewController()
        nextViewController.dataType = currentViewController.dataType?.nextType
        nextViewController.user = currentViewController.user
        nextViewController.navigationItem.rightBarButtonItem = nextBarButtonItem
        
        //Configure for single or multiple selection based on type
        if currentType == .genre {
            nextViewController.tableView.allowsMultipleSelection = false
        } else {
            nextViewController.tableView.allowsMultipleSelection = true
        }
        
        //nextViewController.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "AttributionHeaderCell")

        
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
            case .certification: textLabel.text = certifications[indexPath.row].name
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
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 44.0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return Attribution.view
        
    }
    
    
}

//MARK: - Helper Methods
extension ListTableViewController {
    
    func initializeUI(for type: DataType) {
        //Navigation Bar Title
        self.title = type.title()
    }
    
    func alertUser(withTitle title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        
        present(alertController, animated: true, completion: nil)
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
                        currentViewController.certifications.sort(by: { $0.order < $1.order })
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

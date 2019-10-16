//
//  StartScreenViewController.swift
//  MovieNight
//
//  Created by Gavin Butler on 14-10-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import UIKit

class StartScreenViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let endpoint = TheMovieDB.discover(genre: "14")

    }
}

//MARK: - Segues
extension StartScreenViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard segue.identifier == "FirstSegue" else {
            print("Error:  Segue identifier not registered")
            return
        }
        
        guard let nextListController = segue.destination as? ListTableViewController<Genres> else {
            print("Error:  Cannot cast view controller from segue destination view controller")
            return
        }
        
        nextListController.dataType = .genre
        nextListController.allEntities = Genres()
        
    }
    
}

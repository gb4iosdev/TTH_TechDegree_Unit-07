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
        
        let endpoint = TheMovieDB.discover(genre: "14")

    }
    

}

//MARK: - Segues
extension StartScreenViewController {
    
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

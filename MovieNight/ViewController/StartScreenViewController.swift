//
//  StartScreenViewController.swift
//  MovieNight
//
//  Created by Gavin Butler on 14-10-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import UIKit

class StartScreenViewController: UIViewController {
    
    @IBOutlet weak var leftButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let endpoint = TheMovieDB.discover(genre: "14")

    }
    
    @IBAction func leftButtonPressed(_ sender: UIButton) {
        
        let vc = ListTableViewController<Genres>()
        vc.dataType = .genre
        vc.allEntities = Genres()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

//MARK: - Segues
extension StartScreenViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        print(segue.identifier)
        guard segue.identifier == "FirstSegue" else {
            print("Error:  Segue identifier not registered")
            return
        }
        
        let nextListController = segue.destination as! ListTableViewController<Genres>
        
        //Get the destination view controller - only if the right type
//        guard let nextListController = segue.destination as? ListTableViewController<Genres> else {
//            print("Error:  Attempted segue not registered")
//            return
//        }
        
        nextListController.dataType = .genre
        
    }
    
}

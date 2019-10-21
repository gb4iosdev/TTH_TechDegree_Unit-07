//
//  StartScreenViewController.swift
//  MovieNight
//
//  Created by Gavin Butler on 14-10-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import UIKit

class StartScreenViewController: UIViewController {
    
    var activeUser: User?
    
    @IBOutlet weak var user1SelectionBubble: UIButton!
    @IBOutlet weak var user2SelectionBubble: UIButton!
    @IBOutlet weak var viewResultsButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //Update bubbles if user has completed a selection cycle
        if UserSelection.doneForUser(.user1) {
            user1SelectionBubble.setImage(UIImage(named: "bubble-selected"), for: .disabled)
            user1SelectionBubble.isEnabled = false
        }
        if UserSelection.doneForUser(.user2) {
            user2SelectionBubble.setImage(UIImage(named: "bubble-selected"), for: .disabled)
            user2SelectionBubble.isEnabled = false
        }
        
        //Enable View Results button if appropriate:
        if UserSelection.doneForUser(.user1) && UserSelection.doneForUser(.user2) {
            viewResultsButton.isEnabled = true
            viewResultsButton.alpha = 1.0
        } else {
            viewResultsButton.isEnabled = false
            viewResultsButton.alpha = 0.5
        }
    }
    
    @IBAction func clearPressed(_ sender: UIBarButtonItem) {
        //Erase the current user selections
        UserSelection.emptySelections()
        
        //Set button images to empty bubbles
        user1SelectionBubble.setImage(UIImage(named: "bubble-empty"), for: .normal)
        user1SelectionBubble.isEnabled = true
        user2SelectionBubble.setImage(UIImage(named: "bubble-empty"), for: .normal)
        user2SelectionBubble.isEnabled = true
        
        //disable the View Results button
        viewResultsButton.isEnabled = false
        viewResultsButton.alpha = 0.5
    }

    
}

//MARK: - Segues
extension StartScreenViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "FirstSegue" {
            guard let nextListController = segue.destination as? ListTableViewController else {
                print("Error:  Cannot cast tableView controller from segue destination view controller")
                return
            }
            
            guard let sender = sender as? UIButton else {
                print("Error:  Segue source not recognized")
                return
            }
            
            if sender === user1SelectionBubble {
                activeUser = .user1
            } else if sender === user2SelectionBubble {
                activeUser = .user2
            }
            
            nextListController.dataType = .genre
            nextListController.user = activeUser
            
        } else if segue.identifier == "ResultsSegue" {
            guard let resultsListController = segue.destination as? ResultsTableViewController else {
                print("Error:  Cannot cast tableView controller from segue destination view controller")
                return
            }
            
            if let selectedGenres = UserSelection.combinedGenres() {
                resultsListController.endpoint = TheMovieDB.discover(genre: selectedGenres)
            }
            
            //Prepare endpoint based on both user's selections
        } else {
            print("Error:  Segue identifier not registered")
        }
        
        
    }
    
}

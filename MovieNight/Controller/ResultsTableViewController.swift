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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let endpoint = endpoint else {
            print("Error: Endpoint not initialized")
            return
        }
        
        print(self.endpoint?.request)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

}

//
//  MovieCell.swift
//  MovieNight
//
//  Created by Gavin Butler on 22-10-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import Foundation
import UIKit

class MovieCell: UITableViewCell {
    
    static let reuseIdentifier = "MovieCell"
    
    @IBOutlet weak var artwork: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    
}

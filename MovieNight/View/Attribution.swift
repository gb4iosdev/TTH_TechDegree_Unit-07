//
//  Attribution.swift
//  MovieNight
//
//  Created by Gavin Butler on 26-10-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import Foundation
import UIKit

//Returns the attribution logo and text for the selection and results table views.
class Attribution {
    
    static var view: UIView {
        let attributionView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 44))
        attributionView.backgroundColor = UIColor.white
        attributionView.heightAnchor.constraint(equalToConstant: 44.0)
        
        let attributionLabel = UILabel()
        attributionLabel.translatesAutoresizingMaskIntoConstraints = false
        attributionLabel.numberOfLines = 0
        attributionLabel.text = "This product uses the TMDb API but is not endorsed or certified by TMDb."
        attributionView.addSubview(attributionLabel)
        
        let logoView = UIImageView(frame: CGRect(x: 8, y: 0, width: 100, height: 44))
        logoView.backgroundColor = .black
        logoView.image = UIImage(named: "attributionLogo")
        attributionView.addSubview(logoView)
        
        
        NSLayoutConstraint.activate([
        attributionLabel.leadingAnchor.constraint(equalTo: logoView.trailingAnchor, constant: 8),
        attributionLabel.trailingAnchor.constraint(equalTo: attributionView.trailingAnchor, constant: 0)
        ])
        
        
        return attributionView
    }
}

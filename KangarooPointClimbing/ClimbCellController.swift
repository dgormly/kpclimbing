//
//  ClimbCell.swift
//  KangarooPointClimbing
//
//  Created by Daniel Gormly on 29/6/17.
//  Copyright © 2017 Daniel Gormly. All rights reserved.
//

import UIKit

class ClimbCell: UITableViewCell {

    @IBOutlet weak var initialLabel: UILabel!
    @IBOutlet weak var initialView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var difRatingLabel: UILabel!
  
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        let initialsViewColor = initialView.backgroundColor
        super.setSelected(selected, animated: animated)
        
        if (selected) {
            initialView.backgroundColor = initialsViewColor
        }
    }
    
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        let initialsViewColor = initialView.backgroundColor
        super.setHighlighted(highlighted, animated: animated)
        
        if (highlighted) {
            initialView.backgroundColor = initialsViewColor
        }
    }
    
}

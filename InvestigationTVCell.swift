//
//  InvestigationTableViewCell.swift
//  Project Dragonfly
//
//  Created by Rob Koch on 10/10/16.
//  Copyright © 2016 cse.miamioh. All rights reserved.
//

import UIKit
import FontAwesome_swift

class InvestigationTVCell: UITableViewCell {

    var investigation: Investigation? {
        didSet {
            nameLabel.text = investigation?.title
            dateLabel.text = "Last used: \(investigation!.lastUpdated)"
            setComponentString()
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var componentLabel: UILabel!

    func setComponentString() {
        let string: String
        componentLabel.font = UIFont.fontAwesome(ofSize: 18)
        componentLabel.text = investigation?.componentType.fontAwesomeString
    }
}

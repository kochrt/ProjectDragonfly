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
            dateLabel.text = "Last updated: \(investigation!.lastUpdated)"
            setComponentString()
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var componentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setComponentString() {
        let string: String
        componentLabel.font = UIFont.fontAwesome(ofSize: 18)
        
        switch investigation!.componentType {
        case .Counter:
            string = String.fontAwesomeIcon(name: .sort)
        case .IntervalCounter:
            string = String.fontAwesomeIcon(name: .hourglassHalf)
        case .Stopwatch:
            string = String.fontAwesomeIcon(name: .clockO)
        }
        
        componentLabel.text = string

    }

}

//
//  ExperimentTableViewCell.swift
//  Project Dragonfly
//
//  Created by Rob Koch on 10/10/16.
//  Copyright © 2016 cse.miamioh. All rights reserved.
//

import UIKit

class ExperimentTableViewCell: UITableViewCell {

    var experiment: Experiment? {
        didSet {
            nameLabel.text = experiment?.experimentName
            dateLabel.text = experiment?.date.description
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
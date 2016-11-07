//
//  ComponentTableViewCell.swift
//  Project Dragonfly
//
//  Created by Rob Koch on 10/31/16.
//  Copyright © 2016 cse.miamioh. All rights reserved.
//

import UIKit

class ComponentTableViewCell: UITableViewCell {

    
    @IBOutlet weak var countLabel: UILabel!
    
    var count: Int = 0 {
        didSet {
            countLabel.text = "\(count)"
        }
    }
    
    @IBAction func subtract(_ sender: UIButton) {
        if (count > 0) {
            count -= 1
        }
    }
    
    @IBAction func add(_ sender: UIButton) {
        count += 1
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  AddComponentTVCell.swift
//  Project Dragonfly
//
//  Created by Rob Koch on 12/11/16.
//  Copyright © 2016 cse.miamioh. All rights reserved.
//

import UIKit

class AddComponentTVCell: UITableViewCell {

    @IBOutlet weak var button: UIButton!
    
    var delegate: InvestigationDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        button.layer.borderWidth = 1
        button.layer.borderColor = button.tintColor.cgColor
        button.layer.cornerRadius = 5
    }

    @IBAction func pressed(_ sender: UIButton) {
        delegate?.addComponent()
    }
}

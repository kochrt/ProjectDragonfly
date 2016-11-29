//
//  ComponentTableViewCell.swift
//  Project Dragonfly
//
//  Created by Rob Koch on 10/31/16.
//  Copyright © 2016 cse.miamioh. All rights reserved.
//

import UIKit

class ComponentTableViewCell: UITableViewCell {
    
    var component: Counter!{
        didSet{
            countLabel.text = "\(component.count)"
            nameField.text = component.title!
        }
    }
    @IBOutlet weak var nameField: UITextField!
    
    @IBAction func nameInput(_ sender: UITextField) {
        component.title = sender.text
    }
    
    
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var componentName: UIView!
    
    
    @IBAction func subtract(_ sender: UIButton) {
        if (component.count > 0) {
            component.subtract()
            countLabel.text = "\(component.count)"
        }
    }
    
    @IBAction func add(_ sender: UIButton) {
        component.add()
        countLabel.text = "\(component.count)"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

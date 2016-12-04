//
//  ComponentTableViewCell.swift
//  Project Dragonfly
//
//  Created by Rob Koch on 10/31/16.
//  Copyright © 2016 cse.miamioh. All rights reserved.
//

import UIKit
// CURRENTLY NOT IN USE
class ComponentTVCell: UITableViewCell {
   
    var investigationController: DateUpdated!
    
    var component: Component!{
        didSet{
            nameField.text = component.title!
        }
    }
    @IBOutlet weak var nameField: UITextField!
    
    @IBAction func nameInput(_ sender: UITextField) {
        component.title = sender.text
    }
    
    func initialize(c: Component) {
        component = c
        nameField.text = component.title!
    }
    
    func investigationWasChanged() {
        investigationController.updated(date: Date())
    }
    
//    @IBOutlet weak var countLabel: UILabel!
//    @IBOutlet weak var componentName: UIView!
//    
//    
//    @IBAction func subtract(_ sender: UIButton) {
//        if (component.count > 0) {
//            component.subtract()
//            countLabel.text = "\(component.count)"
//            investigationController.updated(date: Date())
//            
//        }
//    }
//    
//    @IBAction func add(_ sender: UIButton) {
//        component.add()
//        countLabel.text = "\(component.count)"
//        investigationController.updated(date: Date())
//    }
//    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

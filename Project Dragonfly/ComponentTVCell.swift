//
//  ComponentTableViewCell.swift
//  Project Dragonfly
//
//  Created by Rob Koch on 10/31/16.
//  Copyright © 2016 cse.miamioh. All rights reserved.
//

import UIKit

// CURRENTLY NOT IN USE
class ComponentTVCell: UITableViewCell, UITextFieldDelegate {
   
    var investigationController: InvestigationDelegate!
    var component: Component!{ didSet { nameField.text = component.title! } }
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nameField.delegate = self
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print(string)
        if string == "\n" {
            textField.resignFirstResponder()
            return false
        }
        return true
    }
    
}

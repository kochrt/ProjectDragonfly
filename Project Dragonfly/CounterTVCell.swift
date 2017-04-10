//
//  CounterTableViewCell.swift
//  
//
//  Created by Willard, Marian on 11/28/16.
//
//

import UIKit

class CounterTVCell: UITableViewCell, UITextFieldDelegate {
    
    var investigationController: InvestigationDelegate!
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var subtractButton: UIButton!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var countLabel: UILabel!
    
    var counter: Counter! {
        didSet{
            nameField.text = counter.title!
            countLabel.text = "\(counter.count)"
        }
    }
    
    @IBAction func nameInput(_ sender: UITextField) {
        counter.title = sender.text
    }
    
    @IBAction func subtract(_ sender: UIButton) {
        if (counter.count > 0) {
            counter.subtract()
            countLabel.text = "\(counter.count)"
            investigationController.updated(date: Date())
        }
    }
    
    @IBAction func add(_ sender: UIButton) {
        counter.add()
        countLabel.text = "\(counter.count)"
        investigationController.updated(date: Date())
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nameField.delegate = self
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == "\n" {
            textField.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("in textFieldDidBeginEditing")
        investigationController.setActiveField(textField: textField)
    }
    
    func disableButtons(disable: Bool) {
        if(disable) {
            addButton.isEnabled = false
            subtractButton.isEnabled = false
            
            addButton.backgroundColor = UIColor(red: 163/255.0, green: 163/255.0, blue: 163/255.0, alpha: 1.0)
            subtractButton.backgroundColor = UIColor(red: 163/255.0, green: 163/255.0, blue: 163/255.0, alpha: 1.0)
        } else {
            addButton.isEnabled = true
            subtractButton.isEnabled = true
            
            addButton.backgroundColor = UIColor(red: 51/255.0, green: 133/255.0, blue: 204/255.0, alpha: 1.0)
            subtractButton.backgroundColor = UIColor(red: 51/255.0, green: 133/255.0, blue: 204/255.0, alpha: 1.0)
        }
    }

}

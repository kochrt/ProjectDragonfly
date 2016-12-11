//
//  CounterTableViewCell.swift
//  
//
//  Created by Willard, Marian on 11/28/16.
//
//

import UIKit

class CounterTVCell: UITableViewCell {
    
    var investigationController: InvestigationDelegate!
    
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
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

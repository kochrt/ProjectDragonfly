//
//  ExperimentDetailViewController.swift
//  Project Dragonfly
//
//  Created by Rob Koch on 10/10/16.
//  Copyright © 2016 cse.miamioh. All rights reserved.
//

import UIKit

class ExperimentDetailViewController: UIViewController {

    var experiment: Experiment? {
        didSet {
            navigationItem.title = experiment?.experimentName
        }
    }
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descirptionLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    var count = 0 {
        didSet {
            countLabel.text = String(count)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateLabel.text = experiment?.dateString
        descirptionLabel.text = experiment?.question
        
    }
    
    @IBAction func add(_ sender: UIButton) {
        count += 1
    }
    
    @IBAction func subtract(_ sender: AnyObject) {
        count -= 1
    }
    
}

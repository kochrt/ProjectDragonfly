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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateLabel.text = experiment?.dateString
    }
    
}

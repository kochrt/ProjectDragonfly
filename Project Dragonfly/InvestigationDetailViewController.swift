//
//  InvestigationDetailViewController.swift
//  Project Dragonfly
//
//  Created by Rob Koch on 10/10/16.
//  Copyright © 2016 cse.miamioh. All rights reserved.
//

import UIKit

class InvestigationDetailViewController: UIViewController {

    var investigation: Investigation? {
        didSet {
            navigationItem.title = investigation?.title
        }
    }
    
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateLabel.text = investigation?.lastUpdated
    }
}

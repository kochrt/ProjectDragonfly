//
//  ResultsTabBarVC.swift
//  Project Dragonfly
//
//  Created by Rob Koch on 3/27/17.
//  Copyright © 2017 cse.miamioh. All rights reserved.
//

import UIKit

class ResultsTabBarVC: UITabBarController {

    var investigation: Investigation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for vc in viewControllers! {
            if let chartVC = vc as? ChartVC {
                chartVC.investigation = investigation
            }
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func done(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    // TODO
    @IBAction func share(_ sender: UIBarButtonItem) {
        
    }
}

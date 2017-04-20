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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Button to get you back to the collection slide.
    @IBAction func done(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    // Share function.
    @IBAction func share(_ sender: UIBarButtonItem) {
        if let chartVC = selectedViewController as? ChartVC {
            let (string, image) = chartVC.share()
            var items = [Any]()
            if let s = string {
                items.append(s)
            }
            if let i = image {
                items.append(i)
            }
            let shareController = UIActivityViewController(activityItems: items, applicationActivities: nil)
            if let popover = shareController.popoverPresentationController {
                popover.barButtonItem = sender as UIBarButtonItem
                present(shareController, animated: true, completion: nil)
            }
        }
    }
}

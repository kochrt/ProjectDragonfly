//
//  ChartViewController.swift
//  Project Dragonfly
//
//  Created by Rob Koch on 3/27/17.
//  Copyright © 2017 cse.miamioh. All rights reserved.
//

import UIKit
import Charts

protocol Share {
    func share() -> (String?, UIImage?)
}

class ChartVC: UIViewController, Share {

    // Outlet for chart title on each result page.
    @IBOutlet weak var chartTitle: UILabel!

    // Outlet for the view of the chart.
    @IBOutlet weak var chartView: ChartViewBase!

    // Variable for the investigations
    var investigation: Investigation!
    
    // Colors for the graph components
    var colors: [UIColor] = Styling.Colors.resultColors
    
    // Share function for each graph.
    func share() -> (String?, UIImage?) {
        let shareStr = "Check out this investigation I made in the Dragonfly App: \(investigation.question)"
        return (shareStr, getScreenshot())
    }
    
    // Function to get a screenshot of the graph page.
    func getScreenshot() -> UIImage {
        // grab reference to the view you'd like to capture
        let wholeScreen = self.view!
        
        // define the size and grab a UIImage from it
        UIGraphicsBeginImageContextWithOptions(wholeScreen.bounds.size, wholeScreen.isOpaque, 0.0);
        
        wholeScreen.layer.render(in: UIGraphicsGetCurrentContext()!)
        
        let screengrab = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return screengrab!
    }

}


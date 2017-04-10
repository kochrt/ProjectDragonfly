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
    @IBOutlet weak var chartTitle: UILabel!
    @IBOutlet weak var chartView: ChartViewBase!
    var investigation: Investigation!
    
    var colors: [UIColor] = Styling.Colors.resultColors
    
    func share() -> (String?, UIImage?) {
        let shareStr = "Check out this investigation I made in the Dragonfly App: \(investigation.question)"
        return (shareStr, getScreenshot())
    }
    
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

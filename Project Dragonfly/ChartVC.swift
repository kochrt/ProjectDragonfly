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
    
    var colors: [NSUIColor] = [
        UIColor(red: 24/250, green: 175/250, blue: 140/250, alpha: 1),
        UIColor(red: 44/250, green: 58/250, blue: 68/250, alpha:1),
        UIColor(red: 231/250, green: 110/250, blue: 114/250, alpha: 1),
        UIColor(red: 172/250, green: 189/250, blue: 201/250, alpha: 1),
        UIColor(red: 51/250, green: 133/250, blue: 204/250, alpha: 1),
        UIColor(red: 240/250, green: 133/250, blue: 71/250, alpha: 1),
        UIColor(red: 0, green: 0, blue: 0, alpha: 1),
        UIColor(red: 66/250, green: 88/250, blue: 102/250, alpha: 1),
        UIColor(red: 153/250, green: 76/250, blue: 0, alpha: 1),
        UIColor(red: 150/250, green: 97/250, blue: 219/250, alpha: 1)]
    
    func share() -> (String?, UIImage?) {
        let shareStr = "Check out this investigation I made in the Dragonfly App! Question:\(investigation.question)"
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

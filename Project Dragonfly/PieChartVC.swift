//
//  PieChartVC.swift
//  Project Dragonfly
//
//  Created by Rob Koch on 3/27/17.
//  Copyright © 2017 cse.miamioh. All rights reserved.
//

import UIKit
import Charts

class PieChartVC: ChartVC {

    var pieDataEntries = [ChartDataEntry]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let pieChart = chartView as! PieChartView
        pieChartEnable(pieChart: pieChart)
        // Do any additional setup after loading the view.
    }

    func pieChartEnable(pieChart: PieChartView) {
        chartTitle.text = investigation.title
        var i = 0
        for values in investigation.getInfo() {
            let dataEntry = PieChartDataEntry(value: Double(values.value), label: values.name, data: Double(i) as AnyObject?)
            pieDataEntries.append(dataEntry)
            i += 1
        }
        
        let pieDataSet = PieChartDataSet(values: pieDataEntries, label: "")
        pieDataSet.sliceSpace = 4.0
        
        pieDataSet.colors = colors
        
        let data = PieChartData(dataSet: pieDataSet)
        
        data.setValueFont(UIFont(name: "HelveticaNeue-Light", size: 9.0))
        data.setValueTextColor(UIColor.black)
        
        pieChart.data = data
        pieChart.animate(yAxisDuration: 1.4, easingOption: ChartEasingOption.easeInCubic)
        
//        pieChart.extraTopOffset = 20.0;
    }
    
    @IBAction func share(_ sender: Any) {
        let shareString = "Check out this investigation I made in the Dragonfly App!"
        
        let shareController = UIActivityViewController(activityItems: [shareString, getScreenshot()], applicationActivities: nil)
        if let popover = shareController.popoverPresentationController {
            popover.barButtonItem = sender as? UIBarButtonItem
            present(shareController, animated: true, completion: nil)
        }
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

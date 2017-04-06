//
//  BarChartVC.swift
//  Project Dragonfly
//
//  Created by Rob Koch on 3/27/17.
//  Copyright © 2017 cse.miamioh. All rights reserved.
//

import UIKit
import Charts

class BarChartVC: ChartVC, IAxisValueFormatter, ChartViewDelegate {

    var barDataEntries = [ChartDataEntry]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let barChart = chartView as! BarChartView
        barChartEnable(barChart: barChart)
    }

    func barChartEnable(barChart: BarChartView) {
        chartTitle.text = investigation.question
        barChart.delegate = self
        
        
        let xaxis:XAxis = XAxis()
        
        let info = investigation.getInfo()
        
        for (var i, values) in info.enumerated() {
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(values.value), data: values.name as AnyObject?)
            barDataEntries.append(dataEntry)
            i += 1
        }
        
        xaxis.valueFormatter = self
        
        barChart.xAxis.valueFormatter = xaxis.valueFormatter
        
        
        
        let chartDataSet = BarChartDataSet(values: barDataEntries, label: "")
        chartDataSet.colors = colors
        
        // Create bar chart data with data set and array with values for x axis
        let chartData = BarChartData(dataSets: [chartDataSet])
        
        barChart.xAxis.labelPosition = .bottom
        barChart.xAxis.valueFormatter = xaxis.valueFormatter
        barChart.legend.enabled = false
        
        if info.count < 4 {
            barChart.xAxis.labelRotationAngle = 0
        }
        else if info.count > 4 && info.count < 6 {
            barChart.xAxis.labelRotationAngle = 10
        }
        else {
            barChart.xAxis.labelRotationAngle = 45
        }
        
        barChart.drawBordersEnabled = false
        barChart.xAxis.drawGridLinesEnabled = false
        barChart.xAxis.labelCount = info.count
        barChart.chartDescription?.text = ""
        barChart.animate(xAxisDuration: 2, yAxisDuration: 2)
        barChart.drawValueAboveBarEnabled = true
                
        barChart.data = chartData
        
    }
    
    @IBAction func share(_ sender: Any) {
        let shareString = "Check out this investigation I made in the Dragonfly App!"
        
        let shareController = UIActivityViewController(activityItems: [shareString, getScreenshot()], applicationActivities: nil)
        if let popover = shareController.popoverPresentationController {
            popover.barButtonItem = sender as? UIBarButtonItem
            present(shareController, animated: true, completion: nil)
        }
    }

    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return investigation.getInfo()[Int(value)].name
    }
}

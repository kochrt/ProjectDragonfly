//
//  ResultsVC.swift
//  Project Dragonfly
//
//  Created by Rob Koch on 12/2/16.
//  Copyright © 2016 cse.miamioh. All rights reserved.
//

import UIKit
import MessageUI
import Charts

class ResultsVC: UIViewController, MFMailComposeViewControllerDelegate, IAxisValueFormatter, ChartViewDelegate {

    let picker = UISegmentedControl(items: ["   Bar    ", "   Pie    "])
    
    var investigation: Investigation!
    var items : [(String ,Double)]!
    var barDataEntries = [ChartDataEntry]()
    var pieDataEntries = [ChartDataEntry]()
    var pieChart = PieChartView()
    var colors: [NSUIColor] = [.green, .yellow, .red, .magenta, .blue, .brown, .cyan, .darkGray, .gray, .purple]
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var chart: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.addTarget(self, action: #selector(chartType), for: .valueChanged)
        picker.selectedSegmentIndex = 1
        navigationItem.titleView = picker
    }

    func chartType() {
        
        let barChart = BarChartView(frame: chart.frame)
        
        if picker.selectedSegmentIndex == 0 {
            barChartEnable(barChart: barChart)
        } else {
            pieChartEnable()
        }
    }
    
    func chartFrame(_ containerBounds: CGRect) -> CGRect {
        return CGRect(x: containerBounds.origin.x, y: containerBounds.origin.y, width: containerBounds.size.width, height: containerBounds.size.height)
    }
    
    func getMax(items: [(String, Double)]) -> Double {
        var maxSize = 0.0
        for (_, value) in items {
            if value > maxSize {
                maxSize = value
            }
        }
        return maxSize
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    // Change to make it show up on Rob's page thing
    func pieChartEnable() {
        titleLabel.text = investigation.title
        var i = 0
        for values in investigation.getInfo() {
            let dataEntry = PieChartDataEntry(value: Double(i), label: values.name, data: Double(values.value) as AnyObject?)
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
    }

    // Change to make it show up on Rob's page thing
    func barChartEnable(barChart: BarChartView) {
        titleLabel.text = investigation.title
        barChart.delegate = self
        let xaxis:XAxis = XAxis()
        
        var i = 0
        for values in investigation.getInfo() {
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
        
        if investigation.getInfo().count < 4 {
            barChart.xAxis.labelRotationAngle = 0
        }
        else if investigation.getInfo().count > 4 && investigation.getInfo().count < 6 {
            barChart.xAxis.labelRotationAngle = 10
        }
        else {
            barChart.xAxis.labelRotationAngle = 45
        }
        
        barChart.xAxis.labelCount = investigation.getInfo().count
        barChart.chartDescription?.text = "Bar Chart"
        barChart.animate(xAxisDuration: 2, yAxisDuration: 2)
        barChart.data = chartData
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print("Hello")
    }
    
    // Added to go back to the investigation page
    @IBAction func cancel() {
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return investigation.getInfo()[Int(value)].name
    }
}



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

    var colors: [NSUIColor] = [.green, .yellow, .red, .magenta, .blue, .brown, .cyan, .darkGray, .gray, .purple]
    var barDataEntries = [ChartDataEntry]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let barChart = chartView as! BarChartView
        barChartEnable(barChart: barChart)
        // Do any additional setup after loading the view.
    }

    func barChartEnable(barChart: BarChartView) {
        func barChartEnable(barChart: BarChartView) {
            chartTitle.text = investigation.title
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
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        
        return investigation.getInfo()[Int(value)].name
    }
}

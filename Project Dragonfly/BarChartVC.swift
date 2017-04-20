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

    // Variable for holding all of the data for the bars on the graph.
    var barDataEntries = [ChartDataEntry]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Variable for setting the chartView as a BarChartView.
        // This is needed to be able to display the graph on the page.
        let barChart = chartView as! BarChartView

        // Call the barChart func to display the data.
        barChartEnable(barChart: barChart)
    }

    // Create the graph and initialize all the data.
    func barChartEnable(barChart: BarChartView) {
        // Make the barChart view be able to receive events.
        barChart.delegate = self

        // Test to see what the component type of the investigation is.
        // This will then set the title of the page on the results page include the question and seconds if it is applicable.
        if investigation.componentType == .IntervalCounter {
            chartTitle.text = investigation.question + "(" + String(investigation.getTime()) + " seconds.)"
        } else if investigation.componentType == .Counter {
            chartTitle.text = investigation.question
        } else if investigation.componentType == .Stopwatch {
            chartTitle.text = investigation.question + "(" + String(investigation.getTime()) + " seconds.)"
        }

        // Get the information from the investigation ie count amount and name of the item.
        let info = investigation.getInfo()

        // Loop through the values and it to the barDataEntries object.
        for (var i, values) in info.enumerated() {
            // Create a BarChartDataEntry for each item from the investigation.
            // These will become the bars on the bar graph.
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(values.value), data: values.name as AnyObject?)
            // Add these bars to the barDataEntries variable.
            barDataEntries.append(dataEntry)
            i += 1
        }

        // Setup a variable to be able to handle formatting the x axis of the graph.
        let xaxis:XAxis = XAxis()

        // Assign the class as a valueFormatter.
        xaxis.valueFormatter = self

        // Assign the barCharts xAxis valueFormatter to the one that you have created.
        // This allows the xAxis from the barChart to show the ouput from the stringForValue func.
        barChart.xAxis.valueFormatter = xaxis.valueFormatter

        // Variable to hold the bars to the graph along with a description of each bar.
        // The label will display in the legend which is hidden so that value is not needed.
        let chartDataSet = BarChartDataSet(values: barDataEntries, label: "")

        // Set the color of the bars on the graph to the colors defined in ChartVC.
        chartDataSet.colors = colors

        // Set the dependency of the graph to the rightAxis.
        // This makes the rightAxis dictate what the graph will look like.
        // NOTE changes to the left axis will have no effect on the display of the graph.
        chartDataSet.axisDependency = .right

        // Have the graph start at 0.
        barChart.rightAxis.axisMinimum = 0
        barChart.leftAxis.axisMinimum = 0

        // Make the graph increment in intervals of 1.
        barChart.leftAxis.granularity = 1
        barChart.rightAxis.granularity = 1

        // Set the maximum number on the graph to 2 + the largest count in the investigation
        barChart.leftAxis.axisMaximum = chartDataSet.yMax + 2
        barChart.rightAxis.axisMaximum = chartDataSet.yMax + 2

        // Variable to show the left and right axis to display a bar.
        // True to display bar, false to remove it.
        // Mainly for appearance.
        barChart.leftAxis.drawAxisLineEnabled = false
        barChart.rightAxis.drawAxisLineEnabled = false

        // Option to display a gridline that aligns with each bar in the graph vertically.
        barChart.xAxis.drawGridLinesEnabled = false
        barChart.xAxis.drawAxisLineEnabled = false

        // Set the names of the bars to display at the bottom of the graph
        barChart.xAxis.labelPosition = .bottom

        // Set the bar chart data with the data from the array of values for x axis
        let chartData = BarChartData(dataSets: [chartDataSet])

        // Remove the legend from the graph.
        barChart.legend.enabled = false

        // Display the correct amount of bars on the graph.
        // Resizes the graph to sidaply all of the graphs evenly.
        barChart.xAxis.labelCount = info.count

        // Remove the chart description that would show up on the graph int the bottom left corner.
        barChart.chartDescription?.text = ""

        // Adds animation to the bars as they enter the graph.
        // xAxisDuration is for the rate that each bar shows up from left to right.
        // yAxisDuration is  for the rate that those bars reach their given height.
        barChart.animate(xAxisDuration: 2, yAxisDuration: 2)

        // Draws the value of the bar above the bars.
        barChart.drawValueAboveBarEnabled = true

        // Test to see how many investigations there are in the graph.
        // If there are between 4 and 6, then angle the xAxis values (The name of the item) by 10 degrees.
        // If there are more than 6 then angle them at 45 degrees.
        if info.count < 4 {
            barChart.xAxis.labelRotationAngle = 0
        }
        else if info.count > 4 && info.count < 6 {
            barChart.xAxis.labelRotationAngle = 10
        }
        else {
            barChart.xAxis.labelRotationAngle = 45
        }

        // Assign the data and the visual formatting to the data variable of barChart.
        barChart.data = chartData
    }


    // Value formatter for the item names. This will show up on the bottom of the graph.
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return investigation.getInfo()[Int(value)].name
    }
}


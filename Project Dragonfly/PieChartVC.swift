//
//  PieChartVC.swift
//  Project Dragonfly
//
//  Created by Rob Koch on 3/27/17.
//  Copyright © 2017 cse.miamioh. All rights reserved.
//

import UIKit
import Charts

class PieChartVC: ChartVC, ChartViewDelegate {

    // Variable for holding all of the data for the slices on the graph.
    var pieDataEntries = [ChartDataEntry]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Variable for setting the chartView as a PieChartView.
        // This is needed to be able to display the pie chart on the page.
        let pieChart = chartView as! PieChartView

        // Call the pieChart func to display the data.
        pieChartEnable(pieChart: pieChart)
    }

    func pieChartEnable(pieChart: PieChartView) {
        // Make the pieChart view be able to receive events.
        pieChart.delegate = self

        // Sets the title of the graph to the investigation question.
        chartTitle.text = investigation.question

        // Sets the inner text of the pieChart to display the seconds of the of the IntervalCounter.
        if investigation.componentType == .IntervalCounter {
            pieChart.centerText = String(investigation.getTime()) + " seconds"
        }

        // Get the information from the investigation ie count amount and name of the item.
        let info = investigation.getInfo()

        // Loop through the values and it to the pieDataEntries object.
        for (var i, values) in info.enumerated() {
            let dataEntry = PieChartDataEntry(value: Double(values.value), label: values.name, data: Double(i) as AnyObject?)
            pieDataEntries.append(dataEntry)
            i += 1
        }

        // Variable to hold the slices for the pie chart.
        let pieDataSet = PieChartDataSet(values: pieDataEntries, label: "")

        // The space in pixels between the pie-slices
        pieDataSet.sliceSpace = 4.0

        // Set the color of slices to the colors defined in ChartVC.
        pieDataSet.colors = colors

        // Create a variable to hold the Pie Chart.
        let data = PieChartData(dataSet: pieDataSet)

        // Setting the font and color of the text.
        data.setValueFont(UIFont(name: "HelveticaNeue-Light", size: 13.0))
        data.setValueTextColor(UIColor.white)

        // Remove labels from the PieChart slices.
        pieChart.drawEntryLabelsEnabled = false

        // Set the PieCharts data to the data from the investigation
        pieChart.data = data

        // Create an animation for the PieCHart.
        pieChart.animate(yAxisDuration: 1.4, easingOption: ChartEasingOption.easeInCubic)
    }

    @IBAction func share(_ sender: Any) {
        let shareString = "Check out this investigation I made in the Dragonfly App!"

        let shareController = UIActivityViewController(activityItems: [shareString, getScreenshot()], applicationActivities: nil)
        if let popover = shareController.popoverPresentationController {
            popover.barButtonItem = sender as? UIBarButtonItem
            present(shareController, animated: true, completion: nil)
        }
    }


}

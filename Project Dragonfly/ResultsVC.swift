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
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var chart: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        barChart.delegate = self
        picker.addTarget(self, action: #selector(chartType), for: .valueChanged)
        picker.selectedSegmentIndex = 1
        navigationItem.titleView = picker
    }
    
    func chartType() {
        titleLabel.text = investigation.title
        if picker.selectedSegmentIndex == 0 {
            barChartEnable()
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
    
    func pieChartEnable() {
        var i = 0
        for values in investigation.getInfo() {
            let dataEntry = PieChartDataEntry(value: Double(i), label: values.name, data: Double(values.value) as AnyObject?)
            pieDataEntries.append(dataEntry)
            i += 1
        }
    }

    func barChartEnable() {
        
        let xaxis:XAxis = XAxis()
        
        var i = 0
        for values in investigation.getInfo() {
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(values.value), data: values.name as AnyObject?)
            barDataEntries.append(dataEntry)
            i += 1
        }
        
        xaxis.valueFormatter = self
        chart.xAxis.valueFormatter = xaxis.valueFormatter
        
        let chartDataSet = BarChartDataSet(values: barDataEntries, label: "")
        chartDataSet.colors = [.green, .yellow, .red, .magenta, .blue, .brown, .cyan, .darkGray, .gray, .purple]
        
        // Create bar chart data with data set and array with values for x axis
        let chartData = chartData(dataSets: [chartDataSet])
        
        
        chart.xAxis.labelPosition = .bottom
        chart.xAxis.valueFormatter = xaxis.valueFormatter
        chart.legend.enabled = false
        
        if investigation.getInfo().count < 4 {
            chart.xAxis.labelRotationAngle = 0
        }
        else if investigation.getInfo().count > 4 && investigation.getInfo().count < 6 {
            chart.xAxis.labelRotationAngle = 10
        }
        else {
            chart.xAxis.labelRotationAngle = 45
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
    
    func getScreenshot() ->  UIImage{
        // grab reference to the view you'd like to capture
        let wholeScreen = self.view!
        
        // define the size and grab a UIImage from it
        UIGraphicsBeginImageContextWithOptions(wholeScreen.bounds.size, wholeScreen.isOpaque, 0.0);
        
        wholeScreen.layer.render(in: UIGraphicsGetCurrentContext()!)
        
        let screengrab = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return screengrab!
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients(["kochrt@miamioh.edu"])
        mailComposerVC.setSubject("Share Experiment Test")
        mailComposerVC.setMessageBody("Sending e-mail in-app is not so bad!", isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        //  let sendMailErrorController = UIAlertController(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.")
        //  sendMailErrorController.show()
    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
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



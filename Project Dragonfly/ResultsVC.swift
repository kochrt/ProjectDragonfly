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

class ResultsVC: UIViewController, MFMailComposeViewControllerDelegate, IAxisValueFormatter {

    var investigation: Investigation!
    
    var items : [(String ,Double)]!
    
    var dataEntries = [ChartDataEntry]()
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var barChart: BarChartView!
    
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

        let xaxis:XAxis = XAxis()
        
        var i = 0
        for values in investigation.getInfo() {
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(values.value), data: values.name as AnyObject?)
            dataEntries.append(dataEntry)
            stringForValue(Double(i), axis: xaxis)
            i += 1
        }
        
        xaxis.valueFormatter = self
        barChart.xAxis.valueFormatter = xaxis.valueFormatter
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Components")
        chartDataSet.colors = [.green, .yellow, .red, .black, .blue, .brown, .cyan,.darkGray,.gray]
        
        // Create bar chart data with data set and array with values for x axis
        let chartData = BarChartData(dataSets: [chartDataSet])
        
        
        barChart.xAxis.labelPosition = .bottom
        barChart.xAxis.valueFormatter = xaxis.valueFormatter
        
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



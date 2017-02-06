//
//  ResultsVC.swift
//  Project Dragonfly
//
//  Created by Rob Koch on 12/2/16.
//  Copyright © 2016 cse.miamioh. All rights reserved.
//

import UIKit
import MessageUI
import SwiftCharts

class ResultsVC: UIViewController, MFMailComposeViewControllerDelegate {

    var investigation: Investigation!
    
    var items : [(String ,Double)]!
    
    
    @IBOutlet weak var containerView: UIView!
    fileprivate var chart: Chart?
    
    func chartFrame(_ containerBounds: CGRect) -> CGRect {
        return CGRect(x: 0, y: 0, width: containerBounds.size.width, height: containerBounds.size.height)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let investigationType = investigation.componentType
        
        items = investigation.getValues()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        let chartConfig = BarsChartConfig(
            valsAxisConfig: ChartAxisConfig(from: 0, to: self.getMax(items: items) + 2, by: 1)
        )
    
        let frame = self.chartFrame(self.containerView.bounds)
        
        
        let chart = BarsChart(
            frame: frame,
            chartConfig: chartConfig,
            xTitle: "Components",
            yTitle: investigationType.rawValue,
            bars: items,
            color: UIColor.red,
            barWidth: 20
        )
        
        self.view.addSubview(chart.view)
        self.chart = chart
        // Do any additional setup after loading the view.
    }

    // Added to go back to the investigation page
    func cancel() {
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func share(_ sender: Any) {
        print("here we are")
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            print("can mail")
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            print("cannot send mail")
            self.showSendMailErrorAlert()
        }
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

}





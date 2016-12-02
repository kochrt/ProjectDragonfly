//
//  ResultsVC.swift
//  Project Dragonfly
//
//  Created by Rob Koch on 12/2/16.
//  Copyright © 2016 cse.miamioh. All rights reserved.
//

import UIKit
import SwiftCharts

class ResultsVC: UIViewController {

    var investigation: Investigation!
    
    fileprivate var chart: Chart?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        let chartConfig = BarsChartConfig(
            valsAxisConfig: ChartAxisConfig(from: 0, to: 8, by: 2)
        )
        
        var items = investigation.getValues()
        

        
        let chart = BarsChart(
            frame: CGRect(x: 0, y: 70, width: 300, height: 500),
            chartConfig: chartConfig,
            xTitle: "X axis",
            yTitle: "Y axis",
            bars: [
                ("A", 2),
                ("B", 4.5),
                ("C", 3),
                ("D", 5.4),
                ("E", 6.8),
                ("F", 0.5)
            ],
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
        print("share")
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

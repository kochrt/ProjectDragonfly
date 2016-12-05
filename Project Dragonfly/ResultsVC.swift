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
    
    var items : [(String ,Double)]!
    
    @IBOutlet weak var containerView: UIView!
    fileprivate var chart: Chart?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        let chartConfig = BarsChartConfig(
            valsAxisConfig: ChartAxisConfig(from: 0, to: 8, by: 2)
        )
        
        items = investigation.getValues()
        
        let chart = BarsChart(
            frame: containerView.frame,
            chartConfig: chartConfig,
            xTitle: "X axis",
            yTitle: "Y axis",
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

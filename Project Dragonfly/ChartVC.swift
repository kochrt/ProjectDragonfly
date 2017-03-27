//
//  ChartViewController.swift
//  Project Dragonfly
//
//  Created by Rob Koch on 3/27/17.
//  Copyright © 2017 cse.miamioh. All rights reserved.
//

import UIKit
import Charts

class ChartVC: UIViewController {
    @IBOutlet weak var chartTitle: UILabel!
    @IBOutlet weak var chartView: ChartViewBase!
    var investigation: Investigation!
}

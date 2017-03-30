//
//  ChartViewController.swift
//  Project Dragonfly
//
//  Created by Rob Koch on 3/27/17.
//  Copyright © 2017 cse.miamioh. All rights reserved.
//

import UIKit
import Charts

protocol Share {
    func share() -> (String?, UIImage?)
}

class ChartVC: UIViewController, Share {
    @IBOutlet weak var chartTitle: UILabel!
    @IBOutlet weak var chartView: ChartViewBase!
    var investigation: Investigation!
    var colors: [NSUIColor] = [.green, .yellow, .red, .magenta, .blue, .brown, .cyan, .darkGray, .gray, .purple]
    
    func share() -> (String?, UIImage?) {
        return (nil, nil)
    }
}

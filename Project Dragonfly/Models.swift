//
//  Models.swift
//  Project Dragonfly
//
//  Created by Rob Koch on 10/17/16.
//  Copyright © 2016 cse.miamioh. All rights reserved.
//

import Foundation

class Experiment {
    var experimentName: String?
    var question: String?
    var date: NSDate
    
    var dateString: String {
        get {
            let format: String
            let now = NSDate().timeIntervalSince1970 * 1000
            switch now - date.timeIntervalSince1970 * 1000 {
            case 0 ..< 72000000: format = "h:mm a"
            case 72000000 ..< 432000000: format = "EEEE"
            case 432000000 ..< 12000000000: format = "M/d"
            default: format = "MMM 'yy"
            }
            let formatter = NSDateFormatter()
            formatter.dateFormat = format
            return formatter.stringFromDate(date)
        }
    }
    
    var tools: [String]
    
    init(experimentName: String, question: String, date: NSDate) {
        self.experimentName = experimentName
        self.question = question
        self.date = date
        self.tools = [String]()
    }
    
    var description: String {
        get {
            return "\(experimentName): \(question)"
        }
    }
}

class Experiments {
    static let instance = Experiments()
    
    var experiments: [Experiment]
    
    init() {
        experiments = [Experiment]()
    }
}
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
//
//  Models.swift
//  Project Dragonfly
//
//  Created by Rob Koch on 10/17/16.
//  Copyright © 2016 cse.miamioh. All rights reserved.
//

import Foundation

class Experiment {
    var title: String?
    var date: String?
    var description: String?
    
    init(title: String, date: String, desc: String) {
        self.title = title
        self.date = date
        self.description = desc
    }
}
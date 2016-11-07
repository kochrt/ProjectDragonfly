//
// Created by Zachery Eldemire on 10/31/16.
// Copyright (c) 2016 cse.miamioh. All rights reserved.
//

import Foundation

class Component {
    var title: String?
    init(title: String) {
        self.title = title
    }
}

class Counter: Component {
    var count: Int
    init() {
        self.count = 0
        super.init(title: "Counter")
    }

    func add() {
        count += 1
    }

    func subtract() {
        count -= 1
    }
}

class Stopwatch: Component {
    var time: Double

    init() {
        self.time = 0.0
        super.init(title: "Stopwatch")
    }

    func increment() {
        time = time + 0.1
    }
}
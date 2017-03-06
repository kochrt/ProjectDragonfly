//
// Created by Zachery Eldemire on 10/31/16.
// Copyright (c) 2016 cse.miamioh. All rights reserved.
//

import Foundation

class Component: NSObject, NSCoding {
    
    struct Keys {
        static let title = "componentTitle"
        static let count = "componentCount"
        static let time = "componentTime"
    }
    
    var title: String?
    init(title: String) {
        self.title = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        title = aDecoder.decodeObject(forKey: Keys.title) as? String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: Keys.title)
    }
    
    static func componentFromEnum(e: String) -> Component? {
        switch e {
        case ComponentEnum.Counter.rawValue:
            return Counter()
        case ComponentEnum.IntervalCounter.rawValue:
            return Counter()
        case ComponentEnum.Stopwatch.rawValue:
            return Stopwatch()
        default:
            return nil
        }
    }
    
    func clone(cloneWithData: Bool) -> Component {
        let clone = Component(title: self.title!)
        return clone
    }
}

class Counter: Component {
    var count: Int
    
    init() {
        self.count = 0
        super.init(title: "")
    }
    
    override func clone(cloneWithData: Bool) -> Counter {
        let c = Counter()
        c.title = title
        if (cloneWithData) {
            c.count = count
        }
        return c
    }
    
    required init?(coder aDecoder: NSCoder) {
        count = aDecoder.decodeInteger(forKey: Keys.count)
        super.init(coder: aDecoder)
    }
    
    override func encode(with aCoder: NSCoder) {
        super.encode(with: aCoder)
        aCoder.encode(count, forKey: Keys.count)
    }

    func add() { count += 1 }

    func subtract() { count -= 1 }
}

class Stopwatch: Component {
    var time: Double

    init() {
        self.time = 0.0
        super.init(title: "")
    }
    
    override func clone(cloneWithData: Bool) -> Stopwatch {
        let c = Stopwatch()
        c.title = title
        if (cloneWithData) {
            c.time = time
        }
        return c
    }
    
    required init?(coder aDecoder: NSCoder) {
        time = aDecoder.decodeDouble(forKey: Keys.time)
        super.init(coder: aDecoder)
    }
    
    override func encode(with aCoder: NSCoder) {
        super.encode(with: aCoder)
        aCoder.encode(time, forKey: Keys.time)
    }

    func increment() {
        time += 0.1
    }
}

//
// Created by Zachery Eldemire on 10/31/16.
// Copyright (c) 2016 cse.miamioh. All rights reserved.
//

import Foundation

class Category {
    var investigations: [Investigation]
    
    init() {
        self.investigations = [Investigation]()
    }
    
    func add(investigation: Investigation) {
        self.investigations.append(investigation)
    }
    
    func getSize() -> Int {
        return investigations.count
    }
}

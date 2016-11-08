//
// Created by Zachery Eldemire on 10/31/16.
// Copyright (c) 2016 cse.miamioh. All rights reserved.
//

import Foundation

class Category: Comparable {
    
    var title: String
    var investigations: [Investigation]
    
    var count: Int {
        get {
            return investigations.count
        }
    }
    
    init(title: String) {
        self.investigations = [Investigation]()
        self.title = title
    }
    
    func add(investigation: Investigation) {
        self.investigations.append(investigation)
    }
    
    /// Returns a Boolean value indicating whether the value of the first
    /// argument is less than that of the second argument.
    ///
    /// This function is the only requirement of the `Comparable` protocol. The
    /// remainder of the relational operator functions are implemented by the
    /// standard library for any type that conforms to `Comparable`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func <(lhs: Category, rhs: Category) -> Bool {
        return lhs.title < rhs.title
    }
    
    public static func ==(lhs: Category, rhs: Category) -> Bool {
        return lhs.title == rhs.title
    }
    
}

class CategoryList {
    static let instance = CategoryList()
    var list = [Category]()
}

 //
// Created by Zachery Eldemire on 10/31/16.
// Copyright (c) 2016 cse.miamioh. All rights reserved.
//

import Foundation

 class Investigation: CustomStringConvertible {
    var title: String
    var category: String
    var question: String
    var componentType: ComponentEnum
    var components: [Component]
    var date: Date
    var timer: Foundation.NSTimer?

    var description: String {
        get {
            return "\(title): \(question). \(components.count) \(componentType)"
        }
    }
    
    // TODO
    init(question: String, components: [Component], title: String, category: String) {
        self.components = components
        self.question = question
        self.date = Date()
        self.title = title
        self.category = category
        self.componentType = .Counter
    }

    var lastUpdated: String {
        get {
            let format: String
            let now = Date().timeIntervalSince1970 * 1000
            switch now - date.timeIntervalSince1970 * 1000 {
            case 0 ..< 72000000: format = "h:mm a"
            case 72000000 ..< 432000000: format = "EEEE"
            case 432000000 ..< 12000000000: format = "M/d"
            default: format = "MMM 'yy"
            }
            let formatter = DateFormatter()
            formatter.dateFormat = format
            return formatter.string(from: date)
        }
    }
}
 
class Investigations {
    static let instance = Investigations()
    
    // Dictionary of category to investigation
    var investigations = [String : [Investigation]]()
    var sortedCategories = [String]()
    
    // Adds investigation and category
    func addInvestigation(investigation: Investigation) -> IndexPath {
        let cat = investigation.category
        if let _ = investigations[cat] {
            investigations[cat]!.append(investigation)
            return IndexPath(row: investigations[cat]!.count - 1, section: sortedCategories.index(of: cat)!)
        } else {
            // New category
            investigations[cat] = [investigation]
            sortedCategories.append(cat)
            sortedCategories.sort()
            return IndexPath(row: 0, section: sortedCategories.index(of: cat)!)
        }
    }
    
    // TODO
    func investigationForIndexPath(path: IndexPath) -> Investigation {
        let cat = sortedCategories[path.section]
        return investigations[cat]![path.row]
    }
    
    // TODO: remove needs to be implemented
}

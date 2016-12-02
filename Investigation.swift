//
// Created by Zachery Eldemire on 10/31/16.
// Copyright (c) 2016 cse.miamioh. All rights reserved.
//

import Foundation

class Investigation: NSObject, NSCoding {
    
    var title: String
    var category: String
    var question: String
    var componentType: ComponentEnum
    var components: [Component]
    var date: Date
    
    override var description: String { get { return "\(title): \(category)" } }
    
    // TODO
    required init(question: String, components: [Component], title: String, category: String) {
        self.components = components
        self.question = question
        self.date = Date()
        self.title = title
        self.category = category
        self.componentType = .Counter
    }
    
    required init(coder decoder: NSCoder) {
        if let data = decoder.decodeObject(forKey: Keys.components) as? Data {
            if let comps = NSKeyedUnarchiver.unarchiveObject(with: data) as? [Component] {
                self.components = comps
                print("components unarchived")
                for comp in comps {
                    print(comp)
                }
            } else {
                print("couldnt unarchive components")
                self.components = []
            }
        } else {
            print("couldnt decode components")
            self.components = []
        }
        self.question = decoder.decodeObject(forKey: Keys.question) as! String
        self.date = decoder.decodeObject(forKey: Keys.date) as! Date
        self.title = decoder.decodeObject(forKey: Keys.title) as! String
        self.category = decoder.decodeObject(forKey: Keys.category) as! String
        self.componentType = ComponentEnum(rawValue: decoder.decodeObject(forKey: Keys.componentType) as! String)!
    }
    
    struct Keys {
        static let title = "title"
        static let category = "category"
        static let question = "question"
        static let components = "components"
        static let date = "date"
        static let componentType = "componentType"
    }
    
    // MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: Keys.title)
        aCoder.encode(category, forKey: Keys.category)
        aCoder.encode(question, forKey: Keys.question)
        aCoder.encode(date, forKey: Keys.date)
        aCoder.encode(componentType.rawValue, forKey: Keys.componentType)
        
        let data = NSKeyedArchiver.archivedData(withRootObject: components)
        aCoder.encode(data, forKey: Keys.components)
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
    
    func deleteInvestigation(at indexPath: IndexPath) {
        deleteInvestigation(i: investigationForIndexPath(path: indexPath))
    }
    
    func deleteInvestigation(i: Investigation) {
        let cat = i.category
        if var section = investigations[cat] {
            if let index = section.index(of: i) {
                section.remove(at: index)
            }
            investigations[cat] = section
        }
    }
    
    func restoreInvestigations() {
        if let data = UserDefaults.standard.object(forKey: "investigations") as? Data {
            if let tigations = NSKeyedUnarchiver.unarchiveObject(with: data) as? [Investigation] {
                for investigation in tigations {
                    let _ = addInvestigation(investigation: investigation)
                }
            }
        } else {
            print("not data/nothing there")
        }
    }
    
    func saveInvestigations() {
        var array = [Investigation]()
        for (_, arr) in investigations {
            array += arr
        }
        let data = NSKeyedArchiver.archivedData(withRootObject: array)
        UserDefaults.standard.set(data, forKey: "investigations")
    }
}

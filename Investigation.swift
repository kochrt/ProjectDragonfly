//
// Created by Zachery Eldemire on 10/31/16.
// Copyright (c) 2016 cse.miamioh. All rights reserved.
//

import Foundation

struct ComponentInfo {
    var value: Double
    var name: String
}

class Investigation: NSObject, NSCoding {
    
    var title: String
    var category: String
    var question: String
    var componentType: ComponentEnum
    var components: [Component]
    var date: Date
    var timerLength: Double = 0.0
    
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
            } else {
                self.components = []
            }
        } else {
            self.components = []
        }
        self.question = decoder.decodeObject(forKey: Keys.question) as! String
        self.date = decoder.decodeObject(forKey: Keys.date) as! Date
        self.title = decoder.decodeObject(forKey: Keys.title) as! String
        self.category = decoder.decodeObject(forKey: Keys.category) as! String
        self.timerLength = decoder.decodeDouble(forKey: Keys.timerLength)
        self.componentType = ComponentEnum(rawValue: decoder.decodeObject(forKey: Keys.componentType) as! String)!
    }
    
    struct Keys {
        static let title = "title"
        static let category = "category"
        static let question = "question"
        static let components = "components"
        static let date = "date"
        static let componentType = "componentType"
        static let timerLength = "timerLength"
    }
    
    // MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: Keys.title)
        aCoder.encode(category, forKey: Keys.category)
        aCoder.encode(question, forKey: Keys.question)
        aCoder.encode(date, forKey: Keys.date)
        aCoder.encode(componentType.rawValue, forKey: Keys.componentType)
        aCoder.encode(timerLength, forKey: Keys.timerLength)
        
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
    func getTime() -> Double {
        return timerLength
    }
    
    func getInfo() -> [ComponentInfo] {
        var info = [ComponentInfo]()
        
        switch componentType {
        case .Counter, .IntervalCounter:
            for value in components {
                let temp = ComponentInfo(value: Double((value as! Counter).count), name: value.title!)
                info.append(temp)
            }
        case .Stopwatch:
            for value in components {
                let temp = ComponentInfo(value: Double((value as! Stopwatch).time), name: value.title!)
                info.append(temp)
            }
        }
        return info
    }
    
    //clone function which parameterizes the option to clone the data of its components
    //or to clone a version of itself with "reset" component data.
    func clone(cloneWithData: Bool) -> Investigation {
        
        var components_clone = [Component]()
        
        for c in self.components {
            components_clone.append(c.clone(cloneWithData: cloneWithData))
        }
        
        let clone = Investigation(question: self.question, components: components_clone, title: self.title, category: self.category)
        clone.componentType = self.componentType
        clone.title = clone.title + " (copy)"
        
        return clone
    
    }
    
    func setTitle(newTitle: String){
        title = newTitle
    }
    
    func setQuestion(newQuestion: String){
        question = newQuestion
    }
}


// This class represents our collection of our categories, investigations associated with them,
// and the functions to manipulate/organize them
class Investigations {
    static let instance = Investigations()
    
    struct Names {
        static let Uncategorized = "(uncategorized)"
    }
    
    init() {
        let uncat = Names.Uncategorized
        investigations[uncat] = []
    }
    
    //Dictionary that maps category name to a list of investigations
    //effectively contains all data for the app
    var investigations = [String : [Investigation]]()
    var sortedCategories: [String] {
        get {
            return investigations.keys.sorted(by: { $0.lowercased() < $1.lowercased() })
        }
    }
    
    //solution for not displaying empty categories on the investigaiton page
    func getNonEmptyCategories() -> [String]{
        var tmpCategoryNames = [String]()
        for name in investigations.keys.sorted(){
            
            if (investigations[name]?.count != 0) {
                tmpCategoryNames.append(name)
            }
        }
        return tmpCategoryNames
    }
    
    // Adds investigation and category
    func addInvestigation(investigation: Investigation) -> IndexPath {
        let cat = investigation.category
        if let _ = investigations[cat] {
            investigations[cat]!.append(investigation)
            return IndexPath(row: investigations[cat]!.count - 1, section: investigations.keys.sorted().index(of: cat)!)
        } else {
            // New category
            addCategory(name: cat)
            investigations[cat]!.append(investigation)
            return IndexPath(row: 0, section: investigations.keys.sorted().index(of: cat)!)
        }
    }
    
    func investigationForIndexPath(path: IndexPath) -> Investigation {
        let cat = getNonEmptyCategories()[path.section]
        return investigations[cat]![path.row]
    }
    
    
    func deleteInvestigation(at indexPath: IndexPath) {
        deleteInvestigation(i: investigationForIndexPath(path: indexPath))
    }
    
    func deleteInvestigation(i: Investigation) {
        let cat = i.category
        if let section = investigations[cat] {
            investigations[cat] = section.filter { $0 != i }
        }
    }
    
    //This function saves our our String:[Investigation] dictionary to a local file
    func saveInvestigations() {
        let data = NSKeyedArchiver.archivedData(withRootObject: investigations)
        UserDefaults.standard.set(data, forKey: "investigations")
    }
    
    //This takes the data from the aforementioned local file and loads it back into a String:[Investigation] dictionary.
    func restoreInvestigations() {
        if let data = UserDefaults.standard.object(forKey: "investigations") as? Data {
            //embrace the horrible naming
            if let tigations = NSKeyedUnarchiver.unarchiveObject(with: data) as? [String : [Investigation]] {
                for (key, arr) in tigations{
                    addCategory(name: key)
                    for tigation in arr {
                        _ = addInvestigation(investigation: tigation)
                    }
                }
            }
        }
    }
    
    //MOVES INVESTIGATIONS TO UNCATEGORIZED
    func deleteCategory(named: String) {
        guard named != Names.Uncategorized else { return }
        if let array = investigations[named] {
            for i in array {
                i.category = Names.Uncategorized
                let _ = addInvestigation(investigation: i)
            }
            investigations.removeValue(forKey: named)
        }
    }
    
    func deleteCategoryAndInvestigations(named: String) {
        //guard named != Names.Uncategorized else { return }
        if(named == Names.Uncategorized) {
            investigations[named] = [];
        } else {
            investigations.removeValue(forKey: named)
        }
    }
    
    func addCategory(name: String) {
        if(!investigations.keys.contains(name)) {
            investigations[name] = []
        }
    }
    
    func renameCategory(old: String, new: String) {
        addCategory(name: new)
        moveAllInvestigationsInCategory(new: new, old: old)
        deleteCategoryAndInvestigations(named: old)
    }
    
    func moveAllInvestigationsInCategory(new: String, old: String) {
        if(new == old) {
            return
        }
        if investigations[new] != nil {
            investigations[new]! += investigations[old]!
        }
        else {
            investigations[new] = investigations[old]!
        }
        investigations[old] = []
        if let array = investigations[new] {
            for i in array {
                i.category = new
            }
        }
    }
    
    func moveInvestigationToCategory(destCat: String, i: Investigation) {
        if investigations.keys.contains(destCat) {
            let sourceCat = i.category
            i.category = destCat
            _ = addInvestigation(investigation: i)
            i.category = sourceCat
            deleteInvestigation(i: i)
            i.category = destCat
        }
    }
    
}

//
//  NewInvestigationVC.swift
//  Project Dragonfly
//
//  Created by Rob Koch on 11/14/16.
//  Copyright © 2016 cse.miamioh. All rights reserved.
//

import UIKit
import Eureka
import FontAwesome_swift

protocol NewInvestigationDelegate {
    func createdInvestigation(investigation: Investigation)
}

class NewInvestigationVC: FormViewController {

     let alert = UIAlertController(title: "New Category", message: "Enter a category name", preferredStyle: .alert)
    
    var investigation = Investigation(question: "", components: [], title: "", category: Investigations.Names.Uncategorized)
    var delegate: NewInvestigationDelegate? 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupForm()
        setupNewCategoryAlert()
        checkInvestigation()
        checkUncategorized()
        
    }

    @IBOutlet weak var createButton: UIBarButtonItem!
    
    @IBAction func create(_ sender: UIBarButtonItem) {
        addInvestigationToCategory()
    }
    

    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    func checkUncategorized() {
        let catSection = self.form.sectionBy(tag: "Categories")!
        let row: ListCheckRow<String> = catSection.rowBy(tag: Investigations.Names.Uncategorized)!
        row.didSelect()
    }
    
    func setupForm() {
        let titleSection = Section("Title")
        titleSection.append(TextRow() { row in
            row.placeholder = "My Investigation"
            row.onChange({ (text) in
                if let title = text.value {
                    self.investigation.title = title
                }
                self.checkInvestigation()
            })
        })
        form.append(titleSection)
        
        let questionSection = Section("Question")
        questionSection.append(TextAreaRow() { row in
            row.title = "Question"
            row.placeholder = "Why are there no squirrels anymore?"
            row.onChange({ (text) in
                if let question = text.value {
                    self.investigation.question = question
                }
                self.checkInvestigation()
            })
        })
        form.append(questionSection)
        
        let toolSection = SelectableSection<ListCheckRow<String>>("Which tool do you need?", selectionType: .singleSelection(enableDeselection: false))
        
        let tools = [ComponentEnum.Counter, ComponentEnum.IntervalCounter, ComponentEnum.Stopwatch]
        
        for tool in tools {
            toolSection.append(ListCheckRow<String> { row in
                row.title = tool.rawValue
                row.selectableValue = tool.rawValue
                row.value = nil
            }.cellSetup({ (cell, row) in
                cell.imageView?.image = tool.fontAwesomeImage
            }))
        }
        
        toolSection.onSelectSelectableRow = { (cell, row) in
            self.investigation.components.removeAll()
            self.investigation.components.append(Component.componentFromEnum(e: row.selectableValue!)!)
            self.checkInvestigation()
            self.investigation.componentType = ComponentEnum(rawValue: row.selectableValue!)!
        }
        form.append(toolSection)
        

        let newCatSection = Section()
        newCatSection.append(ButtonRow() { row in
            row.title = "Create New Category"
            row.onCellSelection({ (cell, row) in
                self.present(self.alert, animated: true, completion: nil)
                self.checkInvestigation()
            })
            
        })
        form.append(newCatSection)
        
        let categorySection = SelectableSection<ListCheckRow<String>>("Choose a category:", selectionType: .singleSelection(enableDeselection: false))
        categorySection.tag = "Categories"

        for cat in Investigations.instance.investigations.keys.sorted() {
            categorySection.append(ListCheckRow<String>(cat) { row in
                row.title = cat
                row.selectableValue = cat
                row.value = nil
                row.tag = cat
            })
        }
        categorySection.onSelectSelectableRow = { (cell, row) in
            self.investigation.category = row.value!
        }
        form.append(categorySection)
    }
    
    func setupNewCategoryAlert() {
        alert.addTextField { (textField) in
            textField.placeholder = "Category name"
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (_) in }))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            let text = self.alert.textFields![0].text! // Force unwrapping because we know it exists.
            let catSection = self.form.sectionBy(tag: "Categories")!
            
            if (Investigations.instance.investigations.keys.contains(text)) {
                let row: ListCheckRow<String> = catSection.rowBy(tag: text)!
                row.didSelect()
                print("already exists")
            } else {
                print("new category")
                Investigations.instance.addCategory(name: text)
                catSection.append(ListCheckRow<String>(text) { row in
                    row.title = text
                    row.selectableValue = text
                    row.value = nil
                    row.tag = text
                })
                let row: ListCheckRow<String> = catSection.rowBy(tag: text)!
                row.didSelect()
            }
        }))
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    func getComponent(s: String) -> Component? {
        switch(s) {
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
    
    func checkInvestigation() {
        doneButton.isEnabled = investigation.title.characters.count > 0 &&
            investigation.question.characters.count > 0 &&
            investigation.components.count > 0
    }
    
    func addInvestigationToCategory(){
        investigation.date = Date()
        Investigations.instance.addInvestigation(investigation: investigation)
        dismiss(animated: true, completion: {
            self.delegate?.createdInvestigation(investigation: self.investigation)
        })
    }
}

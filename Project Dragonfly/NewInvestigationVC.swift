//
//  NewInvestigationVC.swift
//  Project Dragonfly
//
//  Created by Rob Koch on 11/14/16.
//  Copyright © 2016 cse.miamioh. All rights reserved.
//

import UIKit
import Eureka

class NewInvestigationVC: FormViewController {

     let alert = UIAlertController(title: "New Category", message: "Enter a category name", preferredStyle: .alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupForm()
        setupNewCategoryAlert()
    }

    func setupForm() {
        
        // https://github.com/xmartlabs/Eureka#how-to-create-a-form
        
        let detailSection = Section()
        detailSection.append(TextRow() { row in
            row.title = "Title"
            row.placeholder = "My Investigation"
        })
        detailSection.append(TextRow() { row in
            row.title = "Question"
            row.placeholder = "Why are there no squirrels anymore?"
        })
        
        form.append(detailSection)
        
        let toolSection = SelectableSection<ListCheckRow<String>>("Which tool do you need?", selectionType: .singleSelection(enableDeselection: false))
        
        let tools = ["Comparative Timer", "Counter", "Interval Counter", "Stopwatch"]
        
        for tool in tools {
            toolSection.append(ListCheckRow<String>(tool) { row in
                row.title = tool
                row.selectableValue = tool
                row.value = nil
            })
        }
        form.append(toolSection)
        
        let newCatSection = Section("New Category")
        newCatSection.append(ButtonRow() { row in
            row.title = "Create"
            row.onCellSelection({ (cell, row) in
                self.present(self.alert, animated: true, completion: nil)
            })
            
        })
        form.append(newCatSection)
        
        let categorySection = SelectableSection<ListCheckRow<String>>("Choose a category:", selectionType: .singleSelection(enableDeselection: false))
        categorySection.tag = "Categories"
        
        //let cats = ["None"]
        for cat in Investigations.instance.sortedCategories {
            categorySection.append(ListCheckRow<String>(cat) { row in
                row.title = cat
                row.selectableValue = cat
                row.value = nil
            })
        }
        
        form.append(categorySection)

        
    }
    
    func setupNewCategoryAlert() {
        alert.addTextField { (textField) in
            textField.placeholder = "Category name"
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (_) in }))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            let textField = self.alert.textFields![0] // Force unwrapping because we know it exists.
            Investigations.instance.sortedCategories.append(textField.text!)
            Investigations.instance.sortedCategories.sort()
            
            
            let catSection = self.form.sectionBy(tag: "Categories")
            catSection!.append(ListCheckRow<String>(textField.text!) { row in
                row.title = textField.text!
                row.selectableValue = textField.text!
                row.value = nil
            })
            
        }))
    }
    
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
/*
    func checkInvestigation() -> Bool {
        doneButton.isEnabled = investigation?.title.characters.count > 0 &&
            investigation?.question.characters.count > 0
        return doneButton.isEnabled
    }*/
    
    func createInvestigation() {
        
        
    }

    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        createInvestigation()
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
 

}

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

    override func viewDidLoad() {
        super.viewDidLoad()
        setupForm()
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
        
        let categorySection = SelectableSection<ListCheckRow<String>>("Category", selectionType: .singleSelection(enableDeselection: false))
        for cat in Investigations.instance.sortedCategories {
            categorySection.append(ListCheckRow<String>(cat) { row in
                row.title = cat
                row.selectableValue = cat
                row.value = nil
            })
        }
        form.append(categorySection)
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

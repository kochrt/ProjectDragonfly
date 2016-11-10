//
//  NewExperimentViewController.swift
//  Project Dragonfly
//
//  Created by Rob Koch on 10/17/16.
//  Copyright © 2016 cse.miamioh. All rights reserved.
//

import UIKit
import DropDown
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class NewExperimentViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var experimentTitleTextField: UITextField!
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var toolPickerView: UIPickerView!
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    let dropdown = DropDown()
    @IBOutlet weak var categoryButton: UIButton!
    var categoryButtonHeight: CGFloat = 0.0
    
    
    let alert = UIAlertController(title: "New Category", message: "Enter a category name", preferredStyle: .alert)
    
    var experiment: Experiment?
    var investigation: Investigation?
    
    let tools = [
        "Comparative Timer",
        "Counter",
        "Interval Counter",
        "Stopwatch",
        ]

    
    @IBAction func buttonTap(_ sender: UIButton) {
        dropdown.show()
    }

    
    @IBAction func experimentName(_ sender: UITextField) {
        experiment?.experimentName = sender.text
        investigation?.title = sender.text!
        checkExperiment()
    }
    
    @IBAction func questionText(_ sender: UITextField) {
        experiment?.question = sender.text
        investigation?.question = sender.text!
        checkExperiment()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        experiment = Experiment(experimentName: "", question: "", date: Date())
        investigation = Investigation(question: "", components: [], title: "")
        setUpToolPicker()
        setUpTextFields()
        
        setupDropDown()
        setupNewCategoryAlert()
        
        doneButton.isEnabled = false
    }

    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        categoryButtonHeight = categoryButton.frame.height
        dropdown.topOffset = CGPoint(x: 0, y: -categoryButtonHeight)
    }
    
    // MARK: DropDown
    
    func setupDropDown() {
        dropdown.anchorView = categoryButton
        var temp = ["New"]
        var catList = [String]()
        for i in 0 ..< CategoryList.instance.list.count{
            catList.append(CategoryList.instance.list[i].title)
        }
        temp += catList
        dropdown.dataSource = temp
        
        dropdown.direction = DropDown.Direction.top
        // have to set dropdown offset in viewDidLayoutSubviews. otherwise the button height does not return correct value
        
        dropdown.selectionAction = { [unowned self] (index, item) in
            self.categoryButton.setTitle(item, for: .normal)
            if(item == temp[0]){
                self.present(self.alert, animated: true, completion: nil)
            }
            
        }
        dropdown.selectRow(at: 1)
        self.categoryButton.setTitle(temp[1], for: .normal)
        
    }
    
    // MARK: New Category Alert
    
    func setupNewCategoryAlert() {
        alert.addTextField { (textField) in
            textField.placeholder = "Category name"
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (_) in
            self.dropdown.selectRow(at: 1)
            self.categoryButton.setTitle(self.dropdown.dataSource[1], for: .normal)
            }))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            let textField = self.alert.textFields![0] // Force unwrapping because we know it exists.
            var temp = [""]
            temp[0] = textField.text!
<<<<<<< HEAD
            self.dropdown.dataSource += temp
            let index = self.dropdown.dataSource.count - 1
            self.dropdown.selectRow(at: index)
            self.categoryButton.setTitle(self.dropdown.dataSource[index], for: .normal)
=======
            // new category
            let cat = Category(title: textField.text!)
            // if the investigation is in any category, remove it from that cat.
            for i in 0 ..< CategoryList.instance.list.count{
                if(CategoryList.instance.list[i].investigations.contains(where: { (value) -> Bool in value.title == self.investigation!.title})){
                    let ind = CategoryList.instance.list[i].investigations.index(where: { (value) -> Bool in value.title == self.investigation!.title})
                    CategoryList.instance.list[i].investigations.remove(at: ind!)
                }
            }
            
            // if category already exists, add investigation to that category
            if(CategoryList.instance.list.contains{
                (element) -> Bool in
                element.title == cat.title
            }) {
                let index = CategoryList.instance.list.index(of: cat)!
                CategoryList.instance.list[index].investigations.append(self.investigation!)
                
                let dropIndex = self.dropdown.dataSource.index(of: cat.title)
                self.dropdown.selectRow(at: dropIndex)
                self.categoryButton.setTitle(self.dropdown.dataSource[dropIndex!], for: .normal)
            }  // else create new category and add investigation to new category
            else {
                cat.investigations.append(self.investigation!)
                CategoryList.instance.list.append(cat)
                // update dropdown
                self.dropdown.dataSource += temp
                let index = self.dropdown.dataSource.count - 1
                self.dropdown.selectRow(at: index)
                self.categoryButton.setTitle(self.dropdown.dataSource[index], for: .normal)
            }
>>>>>>> 4864889369a9c9921b16ee357cf20da264735eea
        }))
    }
    
    
    // MARK: Picker View
    func setUpToolPicker() {
        toolPickerView.delegate = self
        toolPickerView.dataSource = self
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return tools.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return tools[row]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // MARK: TextField Stuff
    func setUpTextFields() {
        experimentTitleTextField.delegate = self
        questionTextField.delegate = self
    
        experimentTitleTextField.tag = 0
        questionTextField.tag = 1
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return textField.text?.characters.count < 120
    }
    
    func checkExperiment() -> Bool {
        doneButton.isEnabled = experiment?.experimentName?.characters.count > 0 &&
            experiment?.question!.characters.count > 0
        return doneButton.isEnabled
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addExperiment" {
            Experiments.instance.experiments.insert(self.experiment!, at: 0)
            let vc = segue.destination as! InvestigationTableViewController
            vc.index = 0
        }
    }
}

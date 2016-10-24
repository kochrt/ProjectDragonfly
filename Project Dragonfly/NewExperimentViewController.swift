//
//  NewExperimentViewController.swift
//  Project Dragonfly
//
//  Created by Rob Koch on 10/17/16.
//  Copyright © 2016 cse.miamioh. All rights reserved.
//

import UIKit
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
    
    var experiment: Experiment?
    
    let tools = [
        "Comparative Timer",
        "Counter",
        "Interval Counter",
        "Stopwatch",
        ]
    
   
    @IBAction func experimentName(_ sender: UITextField) {
        experiment?.experimentName = sender.text
        checkExperiment()
    }
    
    @IBAction func questionText(_ sender: UITextField) {
        experiment?.question = sender.text
        checkExperiment()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        experiment = Experiment(experimentName: "", question: "", date: Date())
        
        setUpToolPicker()
        setUpTextFields()
        
        doneButton.isEnabled = false
    }

    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
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
            let vc = segue.destination as! ExperimentsTableViewController
            vc.index = 0
        }
    }
}

//
//  NewExperimentViewController.swift
//  Project Dragonfly
//
//  Created by Rob Koch on 10/17/16.
//  Copyright © 2016 cse.miamioh. All rights reserved.
//

import UIKit

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
    
   
    @IBAction func experimentName(sender: UITextField) {
        experiment?.experimentName = sender.text
        checkExperiment()
    }
    
    @IBAction func questionText(sender: UITextField) {
        experiment?.question = sender.text
        checkExperiment()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        experiment = Experiment(experimentName: "", question: "", date: NSDate())
        
        setUpToolPicker()
        setUpTextFields()
        
        doneButton.enabled = false
    }

    @IBAction func cancel(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func done(sender: UIBarButtonItem) {
        if checkExperiment() {
            Experiments.instance.experiments.append(self.experiment!)
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: Picker View
    func setUpToolPicker() {
        toolPickerView.delegate = self
        toolPickerView.dataSource = self
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return tools.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return tools[row]
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // MARK: TextField Stuff
    func setUpTextFields() {
        experimentTitleTextField.delegate = self
        questionTextField.delegate = self
    
        experimentTitleTextField.tag = 0
        questionTextField.tag = 1
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        return textField.text?.characters.count < 120
    }
    
    func checkExperiment() -> Bool {
        doneButton.enabled = experiment?.experimentName?.characters.count > 0 &&
            experiment?.question!.characters.count > 0
        return doneButton.enabled
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
}

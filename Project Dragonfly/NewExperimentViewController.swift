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
    
    var experiment: Experiment?
    
    let tools = [
        "Comparative Timer",
        "Counter",
        "Interval Counter",
        "Stopwatch",
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        experiment = Experiment(title: "", date: "", desc: "")
        
        setUpToolPicker()
    }

    @IBAction func cancel(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

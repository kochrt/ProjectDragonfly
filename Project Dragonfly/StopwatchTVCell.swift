//
//  StopwatchTableViewCell.swift
//  
//
//  Created by Willard, Marian on 11/28/16.
//
//

import UIKit

// TODO: Why isn't this a subclass of ComponentTVCell
class StopwatchTVCell: UITableViewCell, UITextFieldDelegate {
   
    var investigationController: InvestigationDelegate!
    
    var startTime = TimeInterval()
    var timer = Timer()
    
    var component: Stopwatch!{
        didSet {
            formatTime(eTime: component.time)
            nameField.text = component.title!
        }
    }
    
    @IBAction func nameFieldInput(_ sender: UITextField) {
        component.title = sender.text
    }
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var stopwatchTimeText: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    @IBAction func toggleButton(_ sender: UIButton) {
        if !timer.isValid {
            let aSelector : Selector = #selector(StopwatchTVCell.updateTime)
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: aSelector, userInfo: nil, repeats: true)
            startTime = NSDate.timeIntervalSinceReferenceDate
            
            startButton.setTitle("Stop", for: .normal)
        } else {
            timer.invalidate()
            
            let currentTime = NSDate.timeIntervalSinceReferenceDate
            
            component.time = currentTime - startTime
            startButton.setTitle("Start", for: .normal)
            investigationController.updated(date: Date())
        }
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        investigationController.setActiveField(textField: textField)
    }
    
    func updateTime() {
        
        let currentTime = NSDate.timeIntervalSinceReferenceDate
        
        //Find the difference between current time and start time.
        
        let elapsedTime: TimeInterval = currentTime - startTime
        
        formatTime(eTime: elapsedTime)
        
    }
    
    func formatTime(eTime: TimeInterval) {
        var elapsedTime = eTime
        let minutes = UInt8(elapsedTime / 60.0)
        
        elapsedTime -= (TimeInterval(minutes) * 60)
        
        //calculate the seconds in elapsed time.
        
        let seconds = UInt8(elapsedTime)
        
        elapsedTime -= TimeInterval(seconds)
        
        //find out the fraction of milliseconds to be displayed.
        
        let fraction = UInt8(elapsedTime * 100)
        
        //add the leading zero for minutes, seconds and millseconds and store them as string constants
        
        let strMinutes = String(format: "%02d", minutes)
        let strSeconds = String(format: "%02d", seconds)
        let strFraction = String(format: "%02d", fraction)
        
        //concatenate minuets, seconds and milliseconds as assign it to the UILabel
        
        stopwatchTimeText.text = "\(strMinutes):\(strSeconds):\(strFraction)"
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nameField.delegate = self
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == "\n" {
            textField.resignFirstResponder()
            return false
        }
        return true
    }

}

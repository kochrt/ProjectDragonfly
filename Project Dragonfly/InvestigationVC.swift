//
//  TimedInvestigationVC.swift
//  Project Dragonfly
//
//  Created by Willard, Marian on 12/8/16.
//  Copyright © 2016 cse.miamioh. All rights reserved.
//

import UIKit

class InvestigationVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource, InvestigationDelegate {
    
    let alert = UIAlertController(title: "New Component", message: "Enter a name for this component:", preferredStyle: .alert)
    
    var investigation: Investigation!
    
    var pickerDataSource = Array(repeating: [String](), count: 3)
    
    // for timer
    var startTime = TimeInterval()
    var timer = Timer()
    
    @IBOutlet weak var tableViewToQuestionContstraint: NSLayoutConstraint!
    
    @IBOutlet weak var tableViewToTimerConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var timerView: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var timeButton: UIButton!
    @IBOutlet weak var timerPickerView: UIPickerView!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var questionLabel: UILabel!

    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    @IBAction func clone(_ sender: Any) {
        let c = investigation.clone(cloneWithData: false)
        let _ = Investigations.instance.addInvestigation(investigation: c)
        let _ = navigationController?.popViewController(animated: true)
    }
    @IBAction func changeCategory(_ sender: UIButton) {
        print("change category")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNewComponentAlert()
        setupTimerDataSource()
        
        dateLabel.text = "Last Edited: \(investigation!.lastUpdated)"
        
        // Sets the category to the curent category name
        categoryButton.setTitle(investigation?.category, for: .normal)
        questionLabel.text = investigation?.question
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.tableFooterView = UIView()
        tableView.alwaysBounceVertical = false
        navigationItem.title = investigation?.title
        
        timerPickerView.dataSource = self
        timerPickerView.delegate = self
        resetTimer()
        disableButtons(disable: true)
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if investigation.componentType != .IntervalCounter {
            removeTimer()
        }
    }
    
    func removeTimer() {
        timerView.isHidden = true
        tableViewToTimerConstraint.isActive = !tableViewToTimerConstraint.isActive
        tableViewToQuestionContstraint.isActive = !tableViewToQuestionContstraint.isActive
        updateViewConstraints()
    }
    
    // MARK: *** Timed Counter methods ***
    
    @IBAction func reset(_ sender: UIButton) {
        guard investigation.componentType == .IntervalCounter
            else { return }
        if timer.isValid {
            stopTimer()
        }
        resetTimer()
    }
    
    @IBAction func timerButton(_ sender: UIButton) {
        guard investigation.componentType == .IntervalCounter
            else { return }
        if !timer.isValid {
            startTimer()
        } else {
            stopTimer()
        }
    }
    
    func startTimer() {
        guard investigation.componentType == .IntervalCounter
            else { return }
        disableButtons(disable: false)
        let aSelector : Selector = #selector(InvestigationVC.updateTime)
        self.timer = Timer.scheduledTimer(timeInterval: 0.99, target: self, selector: aSelector, userInfo: nil, repeats: true)
        startTime = NSDate.timeIntervalSinceReferenceDate
        
        setButtonToStop(true)
    }
    
    func stopTimer() {
        guard investigation.componentType == .IntervalCounter
            else { return }
        
        disableButtons(disable: true)
        timer.invalidate()      // invalidate timer
        setButtonToStart(true)  // set button to look like start
        updated(date: Date())   // update the last modified date on the investigation
    }
    
    func updateTime() {
        guard investigation.componentType == .IntervalCounter
            else { return }
        if timer.isValid {
            let currentTime = NSDate.timeIntervalSinceReferenceDate
            
            // Find the difference between current time and start time.
            let elapsedTime: TimeInterval = currentTime - startTime
            
            if (elapsedTime > (investigation.timerLength)) {
                stopTimer()
                resetTimer()
            } else {
                updateTimerView(time: floor(investigation.timerLength - elapsedTime))
            }
        }
    }
    
    func setButtonToStart(_ animated: Bool) {
        guard investigation.componentType == .IntervalCounter
            else { return }
        timeButton.setTitle("Start", for: .normal)
        
        if animated {
            UIView.animate(withDuration: 0.1, animations: {
                self.timeButton.backgroundColor = UIColor(red: 11/255.0, green: 200/255.0, blue: 117/255.0, alpha: 1.0)
            })
            
        } else {
            timeButton.backgroundColor = UIColor(red: 11/255.0, green: 200/255.0, blue: 117/255.0, alpha: 1.0)
        }
        timeButton.setTitleColor(.black, for: .normal)
        timerPickerView.isUserInteractionEnabled = true
    }
    
    func setButtonToStop(_ animated: Bool) {
        guard investigation.componentType == .IntervalCounter
            else { return }
        timeButton.setTitle("Stop", for: .normal)
        
        if animated {
            UIView.animate(withDuration: 0.1, animations: {
                self.timeButton.backgroundColor = UIColor.red
            })
        } else {
            timeButton.backgroundColor = UIColor.red
        }
        timeButton.setTitleColor(.white, for: .normal)
        timerPickerView.isUserInteractionEnabled = false
    }
    
    // this func should only set the timerpickerview to show the time stored in timerLength
    func resetTimer() {
        updateTimerView(time: investigation.timerLength)
    }
    
    func updateTimerView(time: Double) {
        guard investigation.componentType == .IntervalCounter
            else { return }
        var temp = UInt16(time)
        let seconds = UInt16(time) % 60
        temp -= seconds
        temp = temp / 60  // temp is in minutes
        let min = UInt16(temp) % 60
        temp -= min
        let hours = UInt16(temp / 60)
        
        // Make picker display count down
        timerPickerView.selectRow(Int(hours), inComponent: 0, animated: true)
        timerPickerView.selectRow(Int(min), inComponent: 1, animated: true)
        timerPickerView.selectRow(Int(seconds), inComponent: 2, animated: true)
    }
    
    func disableButtons(disable: Bool) {
        guard investigation.componentType == .IntervalCounter
            else { return }
        let cells = self.tableView.visibleCells
        for cell in cells {
            if cell is CounterTVCell {
                let c = cell as! CounterTVCell
                c.disableButtons(disable: disable)
            }
        }
    }
    
    // MARK: *** End Timed Counter Methods ***
    
    func setupNewComponentAlert() {
        alert.addTextField { (textField) in
            textField.placeholder = "Component name"
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (_) in }))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            let textField = self.alert.textFields![0] // Force unwrapping because we know it exists.
            // set created component's name
            let indexPath = IndexPath(row: self.investigation!.components.count, section: 0)
            let comp = Component.componentFromEnum(e: (self.investigation?.componentType.rawValue)!)!
            comp.title = textField.text!
            
            self.investigation!.components.append(comp)
            if(self.investigation.components.count == 10) {
                self.tableView.beginUpdates()
                self.tableView.insertRows(at: [indexPath], with: .automatic)
                self.tableView.deleteRows(at: [IndexPath(row: self.tableView.visibleCells.count, section: 0)], with: .fade)
                self.tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
                self.tableView.endUpdates()
            }
            else {
                self.tableView.insertRows(at: [indexPath], with: .automatic)
            }
            self.disableButtons(disable: true)
        }))
    }
    
    
    // MARK: pickerview stuff
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return pickerDataSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource[component].count;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[component][row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let hours = timerPickerView.selectedRow(inComponent: 0)
        let mins = timerPickerView.selectedRow(inComponent: 1)
        let secs = timerPickerView.selectedRow(inComponent: 2)
        
        let time = secs + (mins * 60) + (hours * 3600)
        investigation.timerLength = Double(time)
    }
    
    func setupTimerDataSource() {
        for i in 0..<3 {
            for j in 0..<60 {
                if i == 0 && j > 23 { break }
                pickerDataSource[i].append("\(i == 2 && j < 10 ? "0" : "")\(j)")
            }
        }
    }
    
    // MARK: tableview stuff
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(investigation!.components.count == 10) {
            return investigation!.components.count
        }
        return investigation!.components.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == investigation.components.count {
            let addComp = tableView.dequeueReusableCell(withIdentifier: "button") as! AddComponentTVCell
            addComp.delegate = self
            addComp.separatorInset = UIEdgeInsetsMake(0, addComp.bounds.size.width, 0, 0)
            addComp.selectionStyle = .none
            return addComp
        }
        
        switch investigation!.componentType {
        case .Counter, .IntervalCounter :
            let comp: Counter = investigation!.components[indexPath.row] as! Counter
            let cell = tableView.dequeueReusableCell(withIdentifier: "counter") as! CounterTVCell
            cell.selectionStyle = .none
            cell.counter = comp
            cell.investigationController = self
            return cell
        case .Stopwatch :
            let comp: Stopwatch = investigation!.components[indexPath.row] as! Stopwatch
            let cell = tableView.dequeueReusableCell(withIdentifier: "stopwatchCell") as! StopwatchTVCell
            cell.selectionStyle = .none
            cell.component = comp
            cell.investigationController = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.row != 0 && indexPath.row != investigation.components.count
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            investigation.components.remove(at: indexPath.row)
            // had 10 comps, deleted one, now have 9, need to insert the add comp button cell
            /*if(investigation.components.count == 9) {
                tableView.beginUpdates()
                tableView.deleteRows(at: [indexPath], with: .automatic)
                tableView.insertRows(at: [IndexPath(row: tableView.visibleCells.count, section: 0)], with: .automatic)
                tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
                tableView.endUpdates()
            }*/
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var destination = segue.destination as? UIViewController
        if let navcon = segue.destination as? UINavigationController {
            destination = navcon.visibleViewController
        }
        if let dest = destination as? ResultsVC {
            dest.investigation = investigation
        }
    }
    
    func updated(date: Date) {
        if let i = investigation {
            i.date = date
            dateLabel.text = "Last Edited: \(i.lastUpdated)"
        }
    }
    
    func addComponent() {
        self.present(self.alert, animated: true, completion: nil)
    }
}

protocol InvestigationDelegate {
    func updated(date: Date)
    func addComponent()
}

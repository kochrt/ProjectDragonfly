//
//  InvestigationTableViewController.swift
//  Project Dragonfly
//
//  Created by Rob Koch on 10/10/16.
//  Copyright © 2016 cse.miamioh. All rights reserved.
//

import UIKit
import DZNEmptyDataSet
import Instructions

class InvestigationsTVC: UITableViewController, NewInvestigationDelegate, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate, CoachMarksControllerDataSource {

    var coachMarksController: CoachMarksController?
    var isFirstTime: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "investigationsTVCViewed")
        }
        set {
            UserDefaults.standard.set(true, forKey: "investigationsTVCViewed")
        }
    }
    
    struct Strings {
        static let InvestigationDetail = "investigationDetail"
        static let CreateInvestigation = "createInvestigation"
    }
    
    let infoAlert = UIAlertController(title: "Hello!", message: "Welcome to the Dragonfly app! This app is used to investigate your environment.", preferredStyle: .alert)
    
    @IBAction func help(_ sender: Any) {
        self.present(infoAlert, animated: true, completion: nil)
    }
    
    func saveVars(){
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.emptyDataSetSource = self
        self.tableView.emptyDataSetDelegate = self
        
        if isFirstTime {
            print("InvestigationsTVC not seen")
        }
        
        self.tableView.tableFooterView = UIView()
//        setupInfoAlert()
//        self.present(infoAlert, animated: true, completion: nil)
        
        if isFirstTime {
            coachMarksController = CoachMarksController()
            self.coachMarksController?.dataSource = self
            self.coachMarksController?.overlay.allowTap = true
            
            let skipView = CoachMarkSkipDefaultView()
            skipView.setTitle("Skip", for: .normal)
            
            self.coachMarksController?.skipView = skipView
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Investigations.instance.saveInvestigations()
        
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if isFirstTime {
            self.coachMarksController?.startOn(self)
        }
    }
    
    // MARK: CoachMarks
    
    /// Asks for the number of coach marks to display.
    ///
    /// - Parameter coachMarksController: the coach mark controller requesting
    ///                                   the information.
    ///
    /// - Returns: the number of coach marks to display.
    func numberOfCoachMarks(for coachMarksController: CoachMarksController) -> Int {
        return 2
    }
    
    func coachMarksController(_ coachMarksController: CoachMarksController, coachMarkAt index: Int) -> CoachMark {
        return coachMarksController.helper.makeCoachMark()
    }
    
    func coachMarksController(_ coachMarksController: CoachMarksController, coachMarkViewsAt index: Int, madeFrom coachMark: CoachMark) -> (bodyView: CoachMarkBodyView, arrowView: CoachMarkArrowView?) {
        let views = coachMarksController.helper.makeDefaultCoachViews(hintText: "hello")
        return (views.bodyView, views.arrowView)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return Investigations.instance.getNonEmptyCategories().count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let cat = Investigations.instance.getNonEmptyCategories()[section]
        return Investigations.instance.investigations[cat]!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "investigation", for: indexPath) as! InvestigationTVCell
        cell.investigation = Investigations.instance.investigationForIndexPath(path: indexPath)
        return cell
    }

    
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
        
    }

    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = Styles.SecondaryColor
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // Returns the title of the section and places the investigation in the correct section
        return Investigations.instance.getNonEmptyCategories()[section]
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let investigation = Investigations.instance.investigationForIndexPath(path: indexPath)
        performSegue(withIdentifier: Strings.InvestigationDetail, sender: investigation)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            Investigations.instance.deleteInvestigation(at: indexPath)
            
            if(tableView.numberOfRows(inSection: indexPath.section) == 1){
                tableView.beginUpdates()
                tableView.deleteRows(at: [indexPath], with: .fade)
                var indexSet = IndexSet()
                indexSet.insert(indexPath.section)
                tableView.deleteSections(indexSet, with: .fade)
                tableView.endUpdates()
                
            } else {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier {
            switch id {
            case Strings.InvestigationDetail:
                let vc = segue.destination as! InvestigationVC
                if let investigation = sender as? Investigation {
                    vc.investigation = investigation
                    let backItem = UIBarButtonItem()
                    backItem.title = "Back"
                    navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
                }
            case Strings.CreateInvestigation:
                if let navcon = segue.destination as? UINavigationController {
                    if let create = navcon.visibleViewController as? NewInvestigationVC {
                        create.delegate = self
                    }
                }
            default: break
            }
        }
    }
    
    // MARK: NewInvestigationDelegate
    func createdInvestigation(investigation: Investigation) {
        performSegue(withIdentifier: Strings.InvestigationDetail, sender: investigation)
    }
    
    // MARK: Empty Data Set
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let text = "no investigations"
        let attributes = [NSFontAttributeName: Styles.HeaderFont.withSize(18.0), NSForegroundColorAttributeName: UIColor.darkGray]
        return NSAttributedString(string: text, attributes: attributes)
    }
    
    func buttonTitle(forEmptyDataSet scrollView: UIScrollView!, for state: UIControlState) -> NSAttributedString! {
        let text = "create new investigation"
        let attributes = [NSFontAttributeName: Styles.HeaderFont.withSize(20.0), NSForegroundColorAttributeName: UIColor.blue]
        return NSAttributedString(string: text, attributes: attributes)

    }
    
    func emptyDataSet(_ scrollView: UIScrollView!, didTap button: UIButton!) {
        performSegue(withIdentifier: Strings.CreateInvestigation, sender: self)
    }
    
    func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return -20.0
    }
    
    // MARK: Alert setup
    func setupInfoAlert() {
        infoAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in }))
        
    }
}


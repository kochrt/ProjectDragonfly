//
//  InvestigationTableViewController.swift
//  Project Dragonfly
//
//  Created by Rob Koch on 10/10/16.
//  Copyright © 2016 cse.miamioh. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class InvestigationsTVC: UITableViewController, NewInvestigationDelegate, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.emptyDataSetSource = self
        self.tableView.emptyDataSetDelegate = self
        
        self.tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return Investigations.instance.sortedCategories.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Investigations.instance.investigations[Investigations.instance.sortedCategories[section]]!.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "investigation", for: indexPath) as! InvestigationTVCell
        cell.investigation = Investigations.instance.investigationForIndexPath(path: indexPath)
        return cell
    }
    
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
        
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // Returns the title of the section and places the investigation in the correct section
        return Investigations.instance.sortedCategories[section]
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let investigation = Investigations.instance.investigationForIndexPath(path: indexPath)
        switch investigation.componentType {
        case .Counter, .Stopwatch:
        performSegue(withIdentifier: "investigationDetail", sender: investigation)
            break
        case .IntervalCounter:
            performSegue(withIdentifier: "timedInvestigation", sender: investigation)
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            Investigations.instance.deleteInvestigation(at: indexPath)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier {
            switch id {
            case "investigationDetail":
                let vc = segue.destination as! InvestigationVC
                if let investigation = sender as? Investigation {
                    vc.investigation = investigation
                }
            case "timedInvestigation":
                let vc = segue.destination as! TimedInvestigationVC
                if let investigation = sender as? Investigation {
                    vc.investigation = investigation
                }
            case "createInvestigation":
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
        if investigation.componentType == .IntervalCounter {
            performSegue(withIdentifier: "timedInvestigation", sender: investigation)
        } else {
            performSegue(withIdentifier: "investigationDetail", sender: investigation)
        }
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
        performSegue(withIdentifier: "createInvestigation", sender: self)
    }
    
    func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return -20.0
    }
}

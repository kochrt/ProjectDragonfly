//
//  InvestigationTableViewController.swift
//  Project Dragonfly
//
//  Created by Rob Koch on 10/10/16.
//  Copyright © 2016 cse.miamioh. All rights reserved.
//

import UIKit

class InvestigationTableViewController: UITableViewController {

    var index: Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let i = Investigation(question: "How many are there", components: [Counter()], title: "Squirrels", category: "New")
        let i2 = Investigation(question: "How many are there", components: [Counter()], title: "Squirrels1", category: "Bew")
        let i3 = Investigation(question: "How many are there", components: [Counter()], title: "Squirrels2", category: "Bew")
        let i4 = Investigation(question: "How many are there", components: [Counter()], title: "Squirrels2", category: "ew")
        Investigations.instance.addInvestigation(investigation: i)
        Investigations.instance.addInvestigation(investigation: i2)
        Investigations.instance.addInvestigation(investigation: i3)
        Investigations.instance.addInvestigation(investigation: i4)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // I forget why we did this
        if index != -1 {
            performSegue(withIdentifier: "investigationDetail", sender: tableView.cellForRow(at: IndexPath(item: index, section: 0)))
        }
        index = -1
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return Investigations.instance.sortedCategories.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Investigations.instance.investigations[Investigations.instance.sortedCategories[section]]!.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "investigation", for: indexPath) as! InvestigationTableViewCell
        cell.investigation = Investigations.instance.investigationForIndexPath(path: indexPath)
        return cell
    }
    
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
        
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // Returns the title of the section and places the investigation in the correct section
        return Investigations.instance.sortedCategories[section]
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
                let vc = segue.destination as! InvestigationViewController
                vc.investigation = (sender as! InvestigationTableViewCell).investigation
            default: break
            }
        }
    }
}


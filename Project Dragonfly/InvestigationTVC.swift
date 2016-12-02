//
//  InvestigationTableViewController.swift
//  Project Dragonfly
//
//  Created by Rob Koch on 10/10/16.
//  Copyright © 2016 cse.miamioh. All rights reserved.
//

import UIKit

class InvestigationTVC: UITableViewController, NewInvestigationDelegate {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Investigations.instance.saveInvestigations()
        tableView.reloadData()
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
        performSegue(withIdentifier: "investigationDetail", sender: investigation)
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
                let vc = segue.destination as! InvestigationVC
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
        performSegue(withIdentifier: "investigationDetail", sender: investigation)
    }
}


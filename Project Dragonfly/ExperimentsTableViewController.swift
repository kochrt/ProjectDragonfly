//
//  ExperimentsTableViewController.swift
//  Project Dragonfly
//
//  Created by Rob Koch on 10/10/16.
//  Copyright © 2016 cse.miamioh. All rights reserved.
//

import UIKit

class ExperimentsTableViewController: UITableViewController {

    var index: Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Experiments.instance.experiments.append(Experiment(experimentName: "Comparing red leaves to green leaves", question: "Are there more green leaves outside?", date: NSDate()))
        Experiments.instance.experiments.append(Experiment(experimentName: "Squirrels", question: "Why are there so many?", date: NSDate(timeInterval: -86000.0, sinceDate: NSDate())))
        Experiments.instance.experiments.append(Experiment(experimentName: "Birds out back", question: "How many birds are in my backyard?", date: NSDate(timeInterval: -604800.0, sinceDate: NSDate())))
        tableView.reloadData()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if index != -1 {
            performSegueWithIdentifier("experimentDetail", sender: tableView.cellForRowAtIndexPath(NSIndexPath(forItem: index, inSection: 0)))
        }
        index = -1
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Experiments.instance.experiments.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("experiment", forIndexPath: indexPath) as! ExperimentTableViewCell

        cell.experiment = Experiments.instance.experiments[indexPath.row]

        return cell
    }
    
    @IBAction func unwind(segue: UIStoryboardSegue) {
        
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
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let id = segue.identifier {
            switch id {
            case "experimentDetail":
                let vc = segue.destinationViewController as! ExperimentDetailViewController
                vc.experiment = (sender as! ExperimentTableViewCell).experiment
            default: break
            }
        }
    }
}


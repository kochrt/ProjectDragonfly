//
//  InvestigationViewController.swift
//  Project Dragonfly
//
//  Created by Rob Koch on 10/31/16.
//  Copyright © 2016 cse.miamioh. All rights reserved.
//

import UIKit

class InvestigationVC: UIViewController, UITableViewDelegate, UITableViewDataSource, DateUpdated {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    var investigation: Investigation!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dateLabel.text = investigation?.lastUpdated
        
        // Sets the category to the curent category name
        categoryLabel.text = investigation?.category
        questionLabel.text = investigation?.question
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.tableFooterView = UIView()
        tableView.alwaysBounceVertical = false
        navigationItem.title = investigation?.title
    }
    
    @IBAction func addComponent(_ sender: Any) {
        let indexPath = IndexPath(row: investigation!.components.count, section: 0)
        investigation!.components.append(Component.componentFromEnum(e: (investigation?.componentType.rawValue)!)!)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return investigation!.components.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // need to: switch (component), then get component cell of that type.
        
        switch investigation!.componentType {
        case ComponentEnum.Counter :
            var comp: Counter = investigation!.components[indexPath.row] as! Counter
            let cell = tableView.dequeueReusableCell(withIdentifier: "component") as! ComponentTVCell
            
            cell.component = comp
            cell.investigationController = self
            return cell
            break
        case ComponentEnum.Stopwatch :
            var comp: Stopwatch = investigation!.components[indexPath.row] as! Stopwatch
            let cell = tableView.dequeueReusableCell(withIdentifier: "stopwatchCell") as! StopwatchTVCell
            cell.component = comp
            //cell.investigationController = self
            return cell
        default:
            break;

        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "component") as! ComponentTVCell
        return cell
        /*
        var comp: Counter = investigation!.components[indexPath.row] as! Counter
        let cell = tableView.dequeueReusableCell(withIdentifier: "component") as! ComponentTableViewCell
        
        cell.component = comp
        return cell*/
    }
    
    func updated(date: Date) {
        investigation?.date = date
    }
}


protocol DateUpdated {
    func updated(date: Date)
}

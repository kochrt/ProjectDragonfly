//
//  InvestigationViewController.swift
//  Project Dragonfly
//
//  Created by Rob Koch on 10/31/16.
//  Copyright © 2016 cse.miamioh. All rights reserved.
//

import UIKit

class InvestigationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    var investigation: Investigation?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dateLabel.text = investigation?.lastUpdated
        
        // Sets the category to the curent category name
        categoryLabel.text = investigation?.category
        
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
        
        var comp: Counter = investigation!.components[indexPath.row] as! Counter
        let cell = tableView.dequeueReusableCell(withIdentifier: "component") as! ComponentTableViewCell
        
        cell.component = comp
        return cell
    }
}

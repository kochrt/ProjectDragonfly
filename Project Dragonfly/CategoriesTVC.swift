//
//  CategoriesTVC.swift
//  Project Dragonfly
//
//  Created by Rob Koch on 3/27/17.
//  Copyright © 2017 cse.miamioh. All rights reserved.
//

import UIKit

class CategoriesTVC: UITableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = Investigations.instance.investigations.keys.sorted().count
        return count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "category", for: indexPath) as UITableViewCell
        let cat = Investigations.instance.investigations.keys.sorted()[indexPath.row]
        cell.textLabel?.text = cat
        let count = Investigations.instance.investigations[cat]!.count
        cell.detailTextLabel?.text = "\(count) investigation\(count > 1 || count == 0 ? "s" : "")"
        cell.selectionStyle = .none
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
}

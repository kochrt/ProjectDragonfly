//
//  CategoryManagementTVC.swift
//  Project Dragonfly
//
//  Created by Rob Koch on 11/21/16.
//  Copyright © 2016 cse.miamioh. All rights reserved.
//

import UIKit

class CategoryManagementTVC: UITableViewController {
    
    @IBAction
    func cancel() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = Investigations.instance.sortedCategories.count
        if count > 1 {
            self.navigationItem.rightBarButtonItem = self.editButtonItem
        }
        return count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "category", for: indexPath) as UITableViewCell
        let cat = Investigations.instance.sortedCategories[indexPath.row]
        cell.textLabel?.text = cat
        let count = Investigations.instance.investigations[cat]!.count
        cell.detailTextLabel?.text = "\(count) investigation\(count > 1 || count == 0 ? "s" : "")"
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // present alert with category name
        let cat = Investigations.instance.sortedCategories[indexPath.row]
        guard cat != Investigations.Names.Uncategorized else { return }
        let alert = setupRenameCategoryAlert(category: cat, indexPath: indexPath)
        self.present(alert, animated: true, completion: nil)
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.row != 0
    }
 
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            Investigations.instance.deleteCategory(named: Investigations.instance.sortedCategories[indexPath.row])
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
            tableView.endUpdates()
            if Investigations.instance.sortedCategories.count > 1 {
                self.navigationItem.rightBarButtonItem = self.editButtonItem
            }
        }
    }
    
    
    func setupRenameCategoryAlert(category: String, indexPath: IndexPath) -> UIAlertController {
        let alert = UIAlertController(title: "Rename Category", message: "Edit the name of this category:", preferredStyle: .alert)
        alert.addTextField { (textField) in
            //textField.placeholder = "Category name"
            textField.text = category
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (_) in }))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            let textField = alert.textFields![0] // Force unwrapping because we know it exists.
            Investigations.instance.renameCategory(old: category, new: textField.text!)
            //self.tableView.reloadRows(at: [indexPath], with: .automatic)
            self.tableView.reloadData()
        }))
        return alert
    }
}

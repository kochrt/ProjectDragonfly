//
//  CategoryManagementTVC.swift
//  Project Dragonfly
//
//  Created by Rob Koch on 11/21/16.
//  Copyright © 2016 cse.miamioh. All rights reserved.
//

import UIKit

class CategoryManagementTVC: CategoriesTVC, ChooseCategoryDelegate {
    
    let alert = UIAlertController(title: "New Category", message: "Enter a category name", preferredStyle: .alert)
    
    var category: String = ""
    
    @IBAction
    func cancel() {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNewCategoryAlert()
    }
    
    @IBAction func addCategory(_ sender: Any) {
        self.present(alert, animated: true, completion: nil)
    }
    
    func setupNewCategoryAlert() {
        alert.addTextField { (textField) in
            textField.placeholder = "Category name"
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (_) in }))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            let text = self.alert.textFields![0].text! // Force unwrapping because we know it exists.
            
            if (!Investigations.instance.investigations.keys.sorted().contains(text)) {
                Investigations.instance.addCategory(name: text)
                self.tableView.reloadData()
            }
        }))
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // present alert with category name
        let cat = Investigations.instance.investigations.keys.sorted()[indexPath.row]
        let optionsSheet = setupOptionsSheet(category: cat, indexPath: indexPath)
        // this prevents the optionsSheet from requiring 2 clicks before appearing, now only needs one click/tap
        DispatchQueue.main.async(execute: {
            self.present(optionsSheet, animated: true, completion: nil)
        })
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.row != 0
    }

    func setupRenameCategoryAlert(category: String, indexPath: IndexPath) -> UIAlertController {
        let alert = UIAlertController(title: "Rename Category", message: "Edit the name of this category:", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.text = category
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in }))
        alert.addAction(UIAlertAction(title: "Rename", style: .default, handler: { (_) in
            let textField = alert.textFields![0]
            Investigations.instance.renameCategory(old: category, new: textField.text!)
            // must use reloadData because renaming categories can cause reordering in the table
            self.tableView.reloadData()
        }))
        return alert
    }
    
    func setupOptionsSheet(category: String, indexPath: IndexPath) -> UIAlertController {
        let optionsSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        optionsSheet.addAction(UIAlertAction(title: "Delete", style: .destructive, handler:{(_) in
            let alert = self.setupDeleteAlert(category: category, indexPath: indexPath)
            self.present(alert, animated: true, completion: nil)
        }));
        
        if(category != Investigations.Names.Uncategorized) {
            optionsSheet.addAction(UIAlertAction(title: "Rename category", style: .default, handler:{(_) in
                let alert = self.setupRenameCategoryAlert(category: category, indexPath: indexPath)
                self.present(alert, animated: true, completion: nil)
            }));
        }
        optionsSheet.addAction(UIAlertAction(title: "Move investigations to...", style: .default, handler:{ (_) in
            self.category = category;
            self.performSegue(withIdentifier: "moveToCategory", sender: self)
            self.tableView.reloadData()
        }));
        
        optionsSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{(_) in }))
        return optionsSheet
    }
    
    func setupDeleteAlert(category: String, indexPath: IndexPath) -> UIAlertController {
        let alert = UIAlertController(title: "Delete Category and...", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Delete investigations", style: .destructive, handler:{(_) in
            Investigations.instance.deleteCategoryAndInvestigations(named: category)
            if(category != Investigations.Names.Uncategorized) {
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            } else {
                self.tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
            }
        }));
        if(category != Investigations.Names.Uncategorized) {
            alert.addAction(UIAlertAction(title: "Move all to Uncategorized", style: .default, handler:{(_) in
                Investigations.instance.deleteCategory(named: category)
                self.tableView.beginUpdates()
                self.tableView.deleteRows(at: [indexPath], with: .fade)
                self.tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
                self.tableView.endUpdates()
            }));
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{(_) in }))

        return alert
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var destination = segue.destination as? UIViewController
        if let navcon = segue.destination as? UINavigationController {
            destination = navcon.visibleViewController
        }
        if let dest = destination as? ChooseCategoryVC {
            dest.investigation = nil
            dest.category = self.category
        }
    }
    
    
    func categoryChosen() {
        tableView.reloadData()
    }
}

//
//  ChooseCategoryVC.swift
//  Project Dragonfly
//
//  Created by Rob Koch on 3/27/17.
//  Copyright © 2017 cse.miamioh. All rights reserved.
//

import UIKit

class ChooseCategoryVC: CategoriesTVC {

    var investigation: Investigation!
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cat: String = (tableView.cellForRow(at: indexPath)?.textLabel?.text)!
        Investigations.instance.moveInvestigationToCategory(destCat: cat, i: investigation)
        dismiss(animated: true, completion: nil)
    }

}

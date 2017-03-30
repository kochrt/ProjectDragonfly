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
    var category: String! = ""
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cat: String = (tableView.cellForRow(at: indexPath)?.textLabel?.text)!
        if(investigation != nil) {
            Investigations.instance.moveInvestigationToCategory(destCat: cat, i: investigation)
        } else {
            Investigations.instance.moveAllInvestigationsInCategory(new: cat, old: category)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.delegate?.backFromCamera()
//    }
    
    

}

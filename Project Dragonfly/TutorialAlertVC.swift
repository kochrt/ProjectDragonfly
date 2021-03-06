//
//  TutorialAlertVC.swift
//  Project Dragonfly
//
//  Created by Rob Koch on 4/17/17.
//  Copyright © 2017 cse.miamioh. All rights reserved.
//

import UIKit

class TutorialAlertVC {
    
    static func create(title: String, messages: [String], buttonTitle: String = "OK", handler: @escaping () -> Void = {}) -> UIAlertController {
        
        let paragraphStyle = NSMutableParagraphStyle()
        let messageText = NSMutableAttributedString(
            string: "\n" + messages.joined(separator: "\n\n"),
            attributes: [
                NSParagraphStyleAttributeName: paragraphStyle,
                NSFontAttributeName : UIFont.preferredFont(forTextStyle: UIFontTextStyle.body),
                NSForegroundColorAttributeName : UIColor.black
            ])
        let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
        alert.setValue(messageText, forKey: "attributedMessage")
        alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: { (_) in
            handler()
        }))
        return alert
    }
}

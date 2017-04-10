//
//  Appearance.swift
//  Project Dragonfly
//
//  Created by Rob Koch on 2/20/17.
//  Copyright © 2017 cse.miamioh. All rights reserved.
//

import Foundation
import UIKit

struct Styling {
    struct Values {
        static let FontName = "Work Sans"
        static let HeaderSize: CGFloat = 17.0
        static let TextColor = UIColor(colorLiteralRed: 66/255.0, green: 88/255.0, blue: 102/255.0, alpha: 1.0)
    }
    
    struct Colors {
        static let Primary = UIColor(colorLiteralRed: 51/255.0, green: 133/255.0, blue: 204/255.0, alpha: 1.0)
        static let Secondary = UIColor(colorLiteralRed: 24/255.0, green: 175/255.01, blue: 140/255.0, alpha: 1.0)
        
        static let resultColors: [UIColor] = [
            UIColor(red: 24/255, green: 175/255, blue: 140/255, alpha: 1),
            UIColor(red: 44/255, green: 58/255, blue: 68/255, alpha:1),
            UIColor(red: 231/255, green: 110/255, blue: 114/255, alpha: 1),
            UIColor(red: 172/255, green: 189/255, blue: 201/255, alpha: 1),
            UIColor(red: 51/255, green: 133/255, blue: 204/255, alpha: 1),
            UIColor(red: 240/255, green: 133/255, blue: 71/255, alpha: 1),
            UIColor(red: 149/255, green: 149/255, blue: 149/255, alpha: 1),
            UIColor(red: 66/255, green: 88/255, blue: 102/255, alpha: 1),
            UIColor(red: 153/255, green: 76/255, blue: 0/255, alpha: 1),
            UIColor(red: 150/255, green: 97/255, blue: 219/255, alpha: 1)
        ]
    }
    

    
    static let HeaderFont = UIFont(name: Values.FontName, size: Values.HeaderSize)!
    
}

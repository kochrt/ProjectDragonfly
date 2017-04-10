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
        
        var resultColors: [UIColor] = [
            UIColor(red: 24, green: 175, blue: 140, alpha: 1),
            UIColor(red: 44, green: 58, blue: 68, alpha:1),
            UIColor(red: 231, green: 110, blue: 114, alpha: 1),
            UIColor(red: 172, green: 189, blue: 201, alpha: 1),
            UIColor(red: 51, green: 133, blue: 204, alpha: 1),
            UIColor(red: 240, green: 133, blue: 71, alpha: 1),
            UIColor(red: 149, green: 149, blue: 149, alpha: 1),
            UIColor(red: 66, green: 88, blue: 102, alpha: 1),
            UIColor(red: 153, green: 76, blue: 0, alpha: 1),
            UIColor(red: 150, green: 97, blue: 219, alpha: 1)]
    }
    

    
    static let HeaderFont = UIFont(name: Values.FontName, size: Values.HeaderSize)!
    
}

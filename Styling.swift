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
    }
    
    static let HeaderFont = UIFont(name: Values.FontName, size: Values.HeaderSize)!
    
}

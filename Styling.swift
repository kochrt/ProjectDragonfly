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
    
    static let HeaderFont = UIFont(name: Values.FontName, size: Values.HeaderSize)!
    
}

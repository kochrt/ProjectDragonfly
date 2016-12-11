//
//  ComponentEnum.swift
//  Project Dragonfly
//
//  Created by Willard, Marian on 11/10/16.
//  Copyright © 2016 cse.miamioh. All rights reserved.
//

import Foundation
import FontAwesome_swift

enum ComponentEnum : String {
    case Counter = "Counter", Stopwatch = "Stopwatch", IntervalCounter = "Interval Counter"
    
    var fontAwesome: FontAwesome {
        get {
            switch self {
            case .Counter:
                return .sort
            case .IntervalCounter:
                return .hourglassHalf
            case .Stopwatch:
                return .clockO
            }
        }
    }
    
    var fontAwesomeString: String {
        return String.fontAwesomeIcon(name: fontAwesome)
    }
    
    var fontAwesomeImage: UIImage {
        return UIImage.fontAwesomeIcon(name: fontAwesome, textColor: .black, size: CGSize(width: 30, height: 30))
    }
    
}

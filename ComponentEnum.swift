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
    
    // string for instructions
    var instructions : [String] {
        get {
            switch self {
            case .Counter:
                return ["Enter a new row for each of the things you want to count.", "To use the Counter, simply tap the plus (+) or minus (-) buttons for each observation you make."]
            case .IntervalCounter:
                return ["Enter a new row for each of the things you want to count.", "To use the interval counter, spin the timer selector to the time limit you want, then hit start.",  "While the timer is running, tap the plus (+) or minus (-) buttons for each observation you make on each row until the timer runs out.", "Tapping the Reset button will reset the timer to the time limit you chose."]
            case .Stopwatch:
                return ["Enter a new row for each of the things you want to time.", "To use the Stopwatch, hit start.", "Allow the stopwatch to run for the length of your observation, then hit stop.", "Run the stopwatch for each row you created."]
            }
        }
    }
    
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

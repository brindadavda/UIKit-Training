//
//  Int64+Extension.swift
//  ApplatchKids
//
//  Created by Zerones M2 on 23/01/24.
//

import Foundation

extension Int64 {
    
    var int:Int {
        return Int(self)
    }
    
    var string:String {
        return String(self)
    }
    
    var double:Double {
        return Double(self)
    }
    
    var cgFloat:CGFloat {
        return CGFloat(self)
    }
    
    func toDate() -> Date {
        return Date(timeIntervalSince1970: TimeInterval(self))
    }
    
    func toMDate() -> Date {
        return Date(timeIntervalSince1970: TimeInterval(self / 1000))
    }
}

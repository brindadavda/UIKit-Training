//
//  Double+Extension.swift
//  ApplatchKids
//
//  Created by Mac on 10/01/24.
//

import UIKit

extension Double {
    
    var string:String {
        return String(self)
    }
    
    var int:Int {
        return Int(self)
    }
    
    var cgFloat:CGFloat {
        return CGFloat(self)
    }
    
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

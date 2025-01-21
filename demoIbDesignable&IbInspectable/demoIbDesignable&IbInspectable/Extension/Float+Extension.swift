//
//  Float+Extension.swift
//  ApplatchKids
//
//  Created by Mac on 10/01/24.
//

import UIKit

extension Float {
    
    var string:String {
        return String(self)
    }
    
    var int:Int {
        return Int(Double(self))
    }
    
    var double:Double {
        return Double(self)
    }
    
    var cgFloat:CGFloat {
        return CGFloat(self)
    }
}

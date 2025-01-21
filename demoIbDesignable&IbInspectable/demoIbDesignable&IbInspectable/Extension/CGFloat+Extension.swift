//
//  CGFloat+Extension.swift
//  ApplatchKids
//
//  Created by Mac on 10/01/24.
//

import Foundation

extension CGFloat {
    
    var string:String {
        return String(Double(self))
    }
    
    var double:Double {
        return Double(self)
    }
    
    var int:Int {
        return Int(self)
    }
    
    var float:Float {
        return Float(self)
    }
    
    var bool:Bool {
        return Int(Double(self)) == 1 ? true : false
    }
}

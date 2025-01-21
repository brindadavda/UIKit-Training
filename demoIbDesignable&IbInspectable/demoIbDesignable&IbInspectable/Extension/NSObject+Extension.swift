//
//  NSObject+Extension.swift
//  ApplatchKids
//
//  Created by Mac on 10/01/24.
//

import Foundation

extension NSObject {
    
    var makeName:String {
        return String(describing: type(of: self))
    }
    
    var stringName:String {
        return String(describing: type(of: self))
    }
}

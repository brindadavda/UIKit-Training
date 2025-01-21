//
//  CGAffineTransform+Extension.swift
//  ApplatchKids
//
//  Created by Mac on 10/01/24.
//

import UIKit

extension CGAffineTransform {
    
    func rotateDegree() -> CGFloat {
        let rotation = CGFloat(atan2f(Float(self.b), Float(self.a)))
        let value = (rotation * 180) / .pi
        if 0 <= value && value <= 180 {
            return value
        }else if 0 >= value && value >= -180 {
            return 360 - abs(value)
        }
        return 0
    }
}

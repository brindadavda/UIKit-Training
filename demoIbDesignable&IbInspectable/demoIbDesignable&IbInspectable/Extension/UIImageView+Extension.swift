//
//  UIImageView+Extension.swift
//  ApplatchKids
//
//  Created by Mac on 10/01/24.
//

import UIKit

extension UIImageView {
    
    @IBInspectable var imageColor:UIColor? {
        get {
            return self.imageColor
        } set {
            if let color = newValue {
                self.color(color)
            }
        }
    }
}

extension UIImageView {
    
    func color(_ color:UIColor?) {
        if let color = color {
            image = image?.withRenderingMode(.alwaysTemplate)
            tintColor = color
        }
    }
    
}

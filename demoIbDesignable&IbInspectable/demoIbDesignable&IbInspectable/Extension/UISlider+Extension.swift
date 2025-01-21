//
//  UISlider+Extension.swift
//  ApplatchKids
//
//  Created by Mac on 10/01/24.
//

import UIKit

extension UISlider {
    
    @IBInspectable var thumbImage:UIImage? {
        get {
            return self.thumbImage
        } set {
            if let image = newValue {
                self.setThumb(image: image)
            }
        }
    }
}

extension UISlider {
    
    func setThumb(image thumbSnapshot: UIImage?) {
        setThumbImage(thumbSnapshot, for: .normal)
        // Step 6
        setThumbImage(thumbSnapshot, for: .highlighted)
        setThumbImage(thumbSnapshot, for: .application)
        setThumbImage(thumbSnapshot, for: .disabled)
        setThumbImage(thumbSnapshot, for: .focused)
        setThumbImage(thumbSnapshot, for: .reserved)
        setThumbImage(thumbSnapshot, for: .selected)

    }
}

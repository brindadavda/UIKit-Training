//
//  CustomeTextFiled.swift
//  instagramClone
//
//  Created by apple on 17/02/24.
//

import UIKit

@IBDesignable
class DesignableUITextField: UITextField {
    
    // Provides left padding for images
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.rightViewRect(forBounds: bounds)
        textRect.origin.x += rightPadding
        return textRect
    }
    
    @IBInspectable var rightImage: UIImage? {
        didSet {
            updateView()
        }
    }
    
    // Provides left padding for images
        override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
            var textRect = super.leftViewRect(forBounds: bounds)
            textRect.origin.x += leftPadding
            return textRect
        }
    
    @IBInspectable var leftImage: UIImage? {
            didSet {
                updateView()
            }
        }
    
    @IBInspectable var leftPadding: CGFloat = 0
    
    @IBInspectable var rightPadding: CGFloat = 0
    
    @IBInspectable var imageWidth: CGFloat = 20
      @IBInspectable var imageHeight: CGFloat = 20
    @IBInspectable var color: UIColor = UIColor.lightGray {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
           if let leftImage = leftImage {
               leftViewMode = UITextField.ViewMode.always
               let leftImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight))
               leftImageView.contentMode = .scaleAspectFit
               leftImageView.image = leftImage
               leftImageView.tintColor = color
               leftView = leftImageView
           } else {
               leftViewMode = UITextField.ViewMode.never
               leftView = nil
           }
           
           if let rightImage = rightImage {
               rightViewMode = UITextField.ViewMode.always
               let rightImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight))
               rightImageView.contentMode = .scaleAspectFit
               rightImageView.image = rightImage
               rightImageView.tintColor = color
               rightView = rightImageView
           } else {
               rightViewMode = UITextField.ViewMode.never
               rightView = nil
           }
           
           // Placeholder text color
           attributedPlaceholder = NSAttributedString(string: placeholder != nil ?  placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: color])
       }
}

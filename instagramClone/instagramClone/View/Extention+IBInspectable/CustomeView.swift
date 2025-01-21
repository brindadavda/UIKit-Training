//
//  CustomeView.swift
//  instagramClone
//
//  Created by apple on 20/02/24.
//
import Foundation
import UIKit

@IBDesignable extension UIView {

    // Corner Radius
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    // Border Width
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    // Border Color
    @IBInspectable var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    // Shadow Effect
    @IBInspectable var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            layer.shadowColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    // Blur Effect
    @IBInspectable var blurEffect: Bool {
        get {
            return false // Placeholder, as you need to customize this based on your requirement.
        }
        set {
            if newValue {
                let blurEffect = UIBlurEffect(style: .light) // You can customize the blur style
                let blurView = UIVisualEffectView(effect: blurEffect)
                blurView.frame = bounds
                blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                addSubview(blurView)
            }
        }
    }
}

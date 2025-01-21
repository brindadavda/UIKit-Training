import UIKit
import ObjectiveC

@IBDesignable
extension UIView {

//    // Corner Radius
//    @IBInspectable var cornerRadius: CGFloat {
//        get {
//            return layer.cornerRadius
//        }
//        set {
//            layer.cornerRadius = newValue
//            layer.masksToBounds = newValue > 0
//        }
//    }
//
//    // Border Width
//    @IBInspectable var borderWidth: CGFloat {
//        get {
//            return layer.borderWidth
//        }
//        set {
//            layer.borderWidth = newValue
//        }
//    }
//
//    // Border Color
//    @IBInspectable var borderColor: UIColor? {
//        get {
//            if let color = layer.borderColor {
//                return UIColor(cgColor: color)
//            }
//            return nil
//        }
//        set {
//            layer.borderColor = newValue?.cgColor
//        }
//    }
//
//    // Shadow Color
//    @IBInspectable var shadowColor: UIColor? {
//        get {
//            if let color = layer.shadowColor {
//                return UIColor(cgColor: color)
//            }
//            return nil
//        }
//        set {
//            layer.shadowColor = newValue?.cgColor
//        }
//    }
//
//    // Shadow Opacity
//    @IBInspectable var shadowOpacity: Float {
//        get {
//            return layer.shadowOpacity
//        }
//        set {
//            layer.shadowOpacity = newValue
//        }
//    }
//
//    // Shadow Radius
//    @IBInspectable var shadowRadius: CGFloat {
//        get {
//            return layer.shadowRadius
//        }
//        set {
//            layer.shadowRadius = newValue
//        }
//    }
//
//    // Shadow Offset
//    @IBInspectable var shadowOffset: CGSize {
//        get {
//            return self.shadowOffset
//        }
//        set {
//            self.shadowOffset = newValue
//            updateShadowLayer()
//        }
//    }
//
//    // Blur Effect
//    @IBInspectable var blurEffect: Bool {
//        get {
//            return objc_getAssociatedObject(self, &AssociatedKeys.blurEffect) as? Bool ?? false
//        }
//        set {
//            objc_setAssociatedObject(self, &AssociatedKeys.blurEffect, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//            updateBlurEffect()
//        }
//    }
//
//    private func updateBlurEffect() {
//        subviews.filter { $0 is UIVisualEffectView }.forEach { $0.removeFromSuperview() }
//
//        if blurEffect {
//            let blurEffect = UIBlurEffect(style: .light)
//            let blurView = UIVisualEffectView(effect: blurEffect)
//            blurView.frame = bounds
//            blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//            addSubview(blurView)
//        }
//    }
//
//    // Gradient Properties
//    @IBInspectable var startColor: UIColor? {
//        get {
//            return objc_getAssociatedObject(self, &AssociatedKeys.startColor) as? UIColor
//        }
//        set {
//            objc_setAssociatedObject(self, &AssociatedKeys.startColor, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//            updateGradient()
//        }
//    }
//
//    @IBInspectable var color1: UIColor? {
//        get {
//            return objc_getAssociatedObject(self, &AssociatedKeys.color1) as? UIColor
//        }
//        set {
//            objc_setAssociatedObject(self, &AssociatedKeys.color1, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//            updateGradient()
//        }
//    }
//
//    @IBInspectable var color2: UIColor? {
//        get {
//            return objc_getAssociatedObject(self, &AssociatedKeys.color2) as? UIColor
//        }
//        set {
//            objc_setAssociatedObject(self, &AssociatedKeys.color2, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//            updateGradient()
//        }
//    }
//
//    @IBInspectable var color3: UIColor? {
//        get {
//            return objc_getAssociatedObject(self, &AssociatedKeys.color3) as? UIColor
//        }
//        set {
//            objc_setAssociatedObject(self, &AssociatedKeys.color3, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//            updateGradient()
//        }
//    }
//
//    @IBInspectable var endColor: UIColor? {
//        get {
//            return objc_getAssociatedObject(self, &AssociatedKeys.endColor) as? UIColor
//        }
//        set {
//            objc_setAssociatedObject(self, &AssociatedKeys.endColor, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//            updateGradient()
//        }
//    }
//
//    @IBInspectable var startPoint: CGPoint {
//        get {
//            return objc_getAssociatedObject(self, &AssociatedKeys.startPoint) as? CGPoint ?? CGPoint(x: 0.5, y: 0.0)
//        }
//        set {
//            objc_setAssociatedObject(self, &AssociatedKeys.startPoint, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//            updateGradient()
//        }
//    }
//
//    @IBInspectable var endPoint: CGPoint {
//        get {
//            return objc_getAssociatedObject(self, &AssociatedKeys.endPoint) as? CGPoint ?? CGPoint(x: 0.5, y: 1.0)
//        }
//        set {
//            objc_setAssociatedObject(self, &AssociatedKeys.endPoint, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//            updateGradient()
//        }
//    }
//
//    private func updateGradient() {
//        // Remove existing gradient layers
//        layer.sublayers?.filter { $0 is CAGradientLayer }.forEach { $0.removeFromSuperlayer() }
//
//        // Create and configure the gradient layer
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.frame = bounds
//        gradientLayer.colors = [startColor?.cgColor, color1?.cgColor, color2?.cgColor, color3?.cgColor, endColor?.cgColor].compactMap { $0 }
//        gradientLayer.startPoint = startPoint
//        gradientLayer.endPoint = endPoint
//
//        // Add the gradient layer to the view's layer
//        layer.insertSublayer(gradientLayer, at: 0)
//    }
//
//    
//    func updateShadowLayer(){
//        let shadowLayer = CALayer()
//        shadowLayer.frame = frame
//        shadowLayer.shadowOffset = shadowOffset
//        layer.addSublayer(shadowLayer)
//    }
//
//    private struct AssociatedKeys {
//        static var blurEffect = "blurEffect"
//        static var startColor = "startColor"
//        static var color1 = "color1"
//        static var color2 = "color2"
//        static var color3 = "color3"
//        static var endColor = "endColor"
//        static var startPoint = "startPoint"
//        static var endPoint = "endPoint"
//    }
//    
//    
//    
//    
    
}



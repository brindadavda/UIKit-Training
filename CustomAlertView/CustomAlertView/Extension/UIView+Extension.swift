//
//  UIView+Extension.swift
//  ApplatchKids
//
//  Created by Mac on 10/01/24.
//

import UIKit

extension UIView {
    
    @IBInspectable var cornerRadius:CGFloat {
        get {
            return  self.cornerRadius
        } set {
            self.layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable var borderWidth:CGFloat {
        get {
            return  self.borderWidth
        } set {
            self.layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor:UIColor? {
        get {
            return  self.borderColor
        } set {
            self.layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable
    var shadowOffset : CGSize{
        
        get{
            return layer.shadowOffset
        }set{
            
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor : UIColor?{
        get{
            return self.shadowColor
        }
        set {
            layer.shadowColor = newValue?.cgColor
        }
    }
    
    @IBInspectable
    var shadowOpacity : Float {
        
        get{
            return layer.shadowOpacity
        }
        set {
            
            layer.shadowOpacity = newValue
            
        }
    }



    // Shadow Radius
    @IBInspectable var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
}


extension UIView {
    
//    
//        func setGradient(bgColor : UIColor) {
//            
//            let viewGradientMessage = GradientBorderView(frame: self.bounds, colorsBackground: [bgColor], colorsBorder: [UIColor.white.withAlphaComponent(0.6) , UIColor.white.withAlphaComponent(0.0)])
//            viewGradientMessage.borderWidthValue = 1
//            viewGradientMessage.cornerRadiusValue = 10
//            viewGradientMessage.backgroundColor = bgColor
//            viewGradientMessage.clipsToBounds = true
//            viewGradientMessage.layer.cornerRadius = viewGradientMessage.cornerRadiusValue
//            self.addSubview(viewGradientMessage)
//            
//        }
//    

    
    
    
    func shadow(roundedRect:CGRect = .zero, cornerRadius:CGFloat = 0, shadowColor:UIColor? = .black, shadowOffset:CGSize = .zero, shadowRadius:CGFloat = 0, shadowOpacity:Float = 0.3) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.clipsToBounds = false
            self.layer.cornerRadius = cornerRadius
            self.layer.shadowPath = UIBezierPath(roundedRect: roundedRect, cornerRadius: cornerRadius).cgPath
            self.layer.shadowColor = shadowColor?.cgColor
            self.layer.shadowOffset = shadowOffset
            self.layer.shadowRadius = shadowRadius
            self.layer.shadowOpacity = shadowOpacity
        }
    }
    
    func boundConstraint(superView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superView.topAnchor, constant: 0),
            leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: 0),
            trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: 0),
            bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: 0),
        ])
    }
    
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
    
    var snapshot: UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        let capturedImage = renderer.image { context in
            layer.render(in: context.cgContext)
        }
        return capturedImage
    }
    
    func rotate(_ angle: CGFloat) {
        let radians = (angle / 180.0) * CGFloat.pi
        self.transform = CGAffineTransform(rotationAngle: radians)
    }
    
    func rotatedDegree() -> CGFloat {
        let radians = atan2(self.transform.b, self.transform.a)
        let degrees = radians * 180 / .pi
        return degrees
    }
    
    func enableView() {
        self.alpha = 1
        self.isUserInteractionEnabled = true
    }
    
    func disableView(_ alpha: CGFloat = 0.5) {
        self.alpha = alpha
        self.isUserInteractionEnabled = true
    }
    
    func clickBounceAnimation(complitionBlock: (() -> ())? = nil) {
        UIView.animate(withDuration: 0.1, animations: { [self] in
            transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }) { _ in
            UIView.animate(withDuration: 0.1, animations: { [self] in
                transform = .identity
            }) { _ in
                complitionBlock?()
            }
        }
    }
    
    class func getAllSubviews<T: UIView>(from parenView: UIView) -> [T] {
        return parenView.subviews.flatMap { subView -> [T] in
            var result = getAllSubviews(from: subView) as [T]
            if let view = subView as? T { result.append(view) }
            return result
        }
    }

    class func getAllSubviews(from parenView: UIView, types: [UIView.Type]) -> [UIView] {
        return parenView.subviews.flatMap { subView -> [UIView] in
            var result = getAllSubviews(from: subView) as [UIView]
            for type in types {
                if subView.classForCoder == type {
                    result.append(subView)
                    return result
                }
            }
            return result
        }
    }

    func getAllSubviews<T: UIView>() -> [T] { return UIView.getAllSubviews(from: self) as [T] }
    func get<T: UIView>(all type: T.Type) -> [T] { return UIView.getAllSubviews(from: self) as [T] }
    func get(all types: [UIView.Type]) -> [UIView] { return UIView.getAllSubviews(from: self, types: types) }

}

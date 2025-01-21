//
//  customeViews.swift
//  demoIbDesignable&IbInspectable
//
//  Created by apple on 13/02/24.
//

/*import UIKit

@IBDesignable
class customeView : UIView{
    
    let PI = 3.14159265359
    
    @IBInspectable var borderWidth: CGFloat = 0 {
       didSet {
          setNeedsLayout()
       }
    }
    
    @IBInspectable var borderColor: UIColor? {
       didSet {
           setNeedsLayout()
       }
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override class func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
    
    private var gradientLayer: CAGradientLayer!
     
     @IBInspectable var topColor: UIColor = .red {
         didSet {
             setNeedsLayout()
         }
     }
     
     @IBInspectable var bottomColor: UIColor = .yellow {
         didSet {
             setNeedsLayout()
         }
     }
     
     @IBInspectable var shadowColor: UIColor = .clear {
         didSet {
             setNeedsLayout()
         }
     }
     
     @IBInspectable var shadowX: CGFloat = 0 {
         didSet {
             setNeedsLayout()
         }
     }
     
     @IBInspectable var shadowY: CGFloat = -3 {
         didSet {
             setNeedsLayout()
         }
     }
     
     @IBInspectable var shadowBlur: CGFloat = 3 {
         didSet {
             setNeedsLayout()
         }
     }
     
     @IBInspectable var startPointX: CGFloat = 0 {
         didSet {
             setNeedsLayout()
         }
     }
     
     @IBInspectable var startPointY: CGFloat = 0.5 {
         didSet {
             setNeedsLayout()
         }
     }
     
     @IBInspectable var endPointX: CGFloat = 1 {
         didSet {
             setNeedsLayout()
         }
     }
     
     @IBInspectable var endPointY: CGFloat = 0.5 {
         didSet {
             setNeedsLayout()
         }
     }
     
     @IBInspectable var cornerRadius: CGFloat = 0 {
         didSet {
             setNeedsLayout()
         }
     }
     
     override class var layerClass: AnyClass {
         return CAGradientLayer.self
     }
     
     override func layoutSubviews() {
         self.gradientLayer = self.layer as? CAGradientLayer
         self.gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
         self.gradientLayer.startPoint = CGPoint(x: startPointX, y: startPointY)
         self.gradientLayer.endPoint = CGPoint(x: endPointX, y: endPointY)
         self.layer.cornerRadius = cornerRadius
         self.layer.shadowColor = shadowColor.cgColor
         self.layer.shadowOffset = CGSize(width: shadowX, height: shadowY)
         self.layer.shadowRadius = shadowBlur
         self.layer.shadowOpacity = 1
         self.layer.borderColor = borderColor?.cgColor
         self.layer.borderWidth = borderWidth
     }

    
    // 1. Set up your enum
    enum StatusShape:Int {
           case Rectangle = 0
           case Triangle = 1
           case Circle = 2
       }

       // Programmatically: use the enum
       var shape:StatusShape = .Rectangle

       // IB: use the adapter
    @IBInspectable var shapeAdapter:Int {
        get {
            return self.shape.rawValue
        }
        set( shapeIndex) {
            self.shape = StatusShape(rawValue: shapeIndex) ?? .Rectangle
        }
    }
    
    
    
    func setCustomeView(){
        let path = UIBezierPath()
        let subShapeLayer = CAShapeLayer()
        switch(self.shape){
        case .Circle :
            circleShape(path: path, layer: subShapeLayer)
            break
        default :
            print("Custome Views")
        }
    }
    
    @IBInspectable var circleRadius : CGFloat = 10
    
    @IBInspectable var circleCenterPoint : CGPoint = CGPoint(x: 0, y: 0)
    
    func circleShape(path : UIBezierPath , layer subShapeLayer : CAShapeLayer){
        path.addArc(withCenter: circleCenterPoint, radius: circleRadius, startAngle: 0, endAngle: 2*PI, clockwise: true)
        subShapeLayer.path = path.cgPath
        subShapeLayer.fillColor = UIColor.black.cgColor
        self.layer.addSublayer(subShapeLayer)
    }
}
*/

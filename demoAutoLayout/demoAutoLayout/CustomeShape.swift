//
//  CustomeShape.swift
//  demoAutoLayout
//
//  Created by apple on 11/03/24.
//
import UIKit

class CustomeShap{
    private let PI = 3.14159
    private let startPoint  : CGPoint!
    private let slightDistance  : CGFloat!
    private var radius : Double!
    private let rotationAngle: CGFloat!
    private let width : CGFloat!
    private let height : CGFloat!
    
    init(radius: Double! = 20, rotationAngle: CGFloat! = -10, width: CGFloat! = 100, height: CGFloat! = 52, slightDistance: CGFloat! = 3, startPoint: CGPoint! = CGPoint(x: 180, y: 200)) {
        self.radius = radius
        self.rotationAngle = rotationAngle
        
        self.slightDistance = slightDistance
        self.startPoint = startPoint
        
        if UIDevice.current.userInterfaceIdiom == .pad{
            self.width = 2*width
            self.height = 2*height
        }else{
            self.width = width
            self.height = height
        }

    }
    
    
    func getCustomeShape() -> CAShapeLayer{
        let shapeLayer = CAShapeLayer()
        
        let path = customPath()
        
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = UIColor.systemRed.cgColor
        shapeLayer.transform = CATransform3DMakeRotation(CGFloat(rotationAngle), 0, 0, 0)
        shapeLayer.fillColor = nil
        shapeLayer.lineWidth = 3
        shapeLayer.fillColor = UIColor.red.cgColor
        
        // Apply rotation transformation
        shapeLayer.setAffineTransform(CGAffineTransform(rotationAngle: rotationAngle * (.pi / 180)))
        
        return shapeLayer;
    }
    
    
    func customPath() -> UIBezierPath{
        let path = UIBezierPath()
        
        
        let p1 =  CGPoint(x: startPoint.x - slightDistance, y: startPoint.y - height + radius)
        let p2 = CGPoint(x: p1.x+width, y: p1.y - radius)
        let p3 = CGPoint(x: p2.x+radius, y: p2.y + height-radius)
        
        path.move(to: startPoint)
        path.addLine(to:p1)
        path.addArc(withCenter: CGPoint(x: p1.x+radius, y: p1.y), radius: radius, startAngle: PI, endAngle: 3*(PI/2), clockwise: true)
        path.addLine(to: p2)
        path.addArc(withCenter: CGPoint(x: p2.x, y: p1.y  ), radius: radius, startAngle: 3*(PI/2), endAngle: 0, clockwise: true)
        path.addLine(to: p3)
        path.addArc(withCenter: CGPoint(x: p3.x-radius, y: p3.y), radius: radius, startAngle: 0, endAngle: (PI/2), clockwise: true)
        path.addLine(to: startPoint)
        
        return path
    }
    

       
}


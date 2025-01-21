//
//  CustomBottomBar.swift
//  demoCustomeShape
//
//  Created by apple on 13/03/24.
//

import UIKit

class CustomBottombar{
    private let PI = 3.14159
    private var radius : Double!
    private var movePoint : CGPoint!
    private var width : CGFloat!
    private var height : CGFloat!
    
    init(radius : Double , movePoint : CGPoint , width : CGFloat , height : CGFloat){
        self.radius = radius
        self.movePoint = movePoint
        self.width = width
        self.height = height
    }
    
    
    func getCustomeShape() -> CAShapeLayer{
        let shapeLayer = CAShapeLayer()
        
        let path = customPath()
        
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = nil
        shapeLayer.fillColor = CGColor(gray: 1, alpha: 1)
        
        return shapeLayer;
    }
    
    
    func customPath() -> UIBezierPath{
        let path = UIBezierPath()
        
        let p1 =  CGPoint(x: movePoint.x + self.width, y: movePoint.y)
        let p2 = CGPoint(x: p1.x + 2*radius + self.width, y: p1.y)
        let p3 = CGPoint(x: p2.x, y: p2.y + height)
        let p4 = CGPoint(x: movePoint.x, y: movePoint.y + height)
        
        path.move(to: self.movePoint)
        path.addLine(to:p1)
        path.addArc(withCenter: CGPoint(x: p1.x+radius, y: p1.y), radius: self.radius, startAngle: PI, endAngle: 0, clockwise: false)
        path.addLine(to: p2)
        path.addLine(to: p3)
        path.addLine(to: p4)
        path.addLine(to: movePoint)
        
        return path
    }
    

}

//
//  CustomeShape.swift
//  demoCustomeShape
//
//  Created by apple on 24/02/24.
//

import UIKit

class CustomeShap{
    private let PI = 3.14159
    private var radius : Double!
    private var movePoint : CGPoint!
    private var count : Int!
    let rotationAngle: CGFloat = -10.0  // 10-degree rotation
    
    
    init(radius : Double , movePoint : CGPoint , count : Int = 1){
        self.radius = radius
        self.movePoint = movePoint
        self.count = count
    }
    
    
    func getCustomeShape() -> CAShapeLayer{
        let shapeLayer = CAShapeLayer()
        
        let path = customPath()
        
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = UIColor.systemRed.cgColor
        shapeLayer.transform = CATransform3DMakeRotation(CGFloat(30), 0, 0, 0)
        shapeLayer.fillColor = nil
        
        // Apply rotation transformation
            shapeLayer.setAffineTransform(CGAffineTransform(rotationAngle: rotationAngle * (.pi / 180)))
        
        return shapeLayer;
    }
    
    
    func customPath() -> UIBezierPath{
        let path = UIBezierPath()
        let radius  : CGFloat = 20
        let width : CGFloat = 150
        let height : CGFloat = 100
        let slightDistance  : CGFloat = 3
        let startPoint = CGPoint(x: 160, y: 200)
        
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

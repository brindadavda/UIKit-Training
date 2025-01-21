//
//  CustomeShape.swift
//  demoProgressBar
//
//  Created by apple on 16/01/24.
//
import UIKit

class CustomeSnakShap{
    private let path = UIBezierPath()
    private let PI = 3.14159
    private var radius : Double!
    private var movePoint : CGPoint!
    private var count : Int!
    
    
    init(radius : Double , movePoint : CGPoint , count : Int = 1){
        self.radius = radius
        self.movePoint = movePoint
        self.count = count
    }
    
    
    func getCustomeShape() -> CAShapeLayer{
        let shapeLayer = CAShapeLayer()
        
       path.move(to: movePoint)
        var endPoint : CGPoint = shape(distance: 250 , movePoint: movePoint)
      
        //declaring var i
        var i = 1
        
        while i < count{
          endPoint = shape(distance: 250 , movePoint: CGPoint(x: endPoint.x, y: endPoint.y+CGFloat(2*radius)))
            i += 1
        }
        
        
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = UIColor.systemRed.cgColor
        shapeLayer.fillColor = nil
        
        return shapeLayer;
    }
    
    
    func linefromMove(startPoint : CGPoint,distance : Double) -> CGPoint{
        let sx : Double = Double(startPoint.x)
        let sy : Double = Double(startPoint.y)
        let endPoint = CGPoint(x: sx+distance, y: sy)
        path.addLine(to: endPoint)
        
        return endPoint
    }
    
    func linefromEnd(startPoint : CGPoint,distance : Double) -> CGPoint{
        let sx : Double = Double(startPoint.x)
        let sy : Double = Double(startPoint.y)
        let endPoint = CGPoint(x: sx-distance, y: sy)
        path.addLine(to: endPoint)
        
        return endPoint
    }
    
    func clockORantiClockArc(center : CGPoint , clockWise : Bool){
        path.addArc(withCenter: center, radius: CGFloat(radius), startAngle: 3*(PI / 2), endAngle:  (PI/2), clockwise: clockWise)
    }
    
    func shape(distance : Double , movePoint : CGPoint) -> CGPoint{
        let endPoint1 : CGPoint = linefromMove(startPoint: movePoint, distance: distance)
        clockORantiClockArc(center: CGPoint(x: endPoint1.x, y: endPoint1.y+CGFloat(radius)), clockWise: true)
        
        let endPoint2 : CGPoint = linefromEnd(startPoint: CGPoint(x: endPoint1.x, y: endPoint1.y+CGFloat(2*radius)), distance: distance)
        
        clockORantiClockArc(center: CGPoint(x: endPoint2.x, y: endPoint2.y+CGFloat(radius)), clockWise: false)
        
        return endPoint2
    }
       
}

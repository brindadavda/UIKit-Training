//
//  customeCircleShape.swift
//  demoMathQuizApp
//
//  Created by apple on 31/01/24.
//

import UIKit

class CustomeCircleShape{
    private let center : CGPoint!
    private let radius : CGFloat!
    
    init(center : CGPoint , radius : CGFloat){
        self.center = center
        self.radius = radius
    }
    
    /* ------- get custome shape layer logic start -------- */
    func customeShape() -> CAShapeLayer{
        let path = getPath()
        let shapelayer = CAShapeLayer()
        shapelayer.path = path.cgPath
        return shapelayer
    }
    /* ------- get custome shape layer logic end -------- */
    
    /* ------ get the circular shape path logic start------- */
    private func getPath() -> UIBezierPath{
        let path = UIBezierPath()
        path.addArc(withCenter: center, radius: radius, startAngle: 0, endAngle: 360, clockwise: true)
        
        return path
    }
    /* ------ get the circular shape path logic end------- */
}

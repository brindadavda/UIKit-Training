//
//  CustomeGradientView.swift
//  instagramClone
//
//  Created by apple on 22/02/24.
//

import Foundation
import UIKit

class GradientView : UIView{
    
    private let colors : [CGColor]
    private let startPoint : CGPoint
    private let endPoint : CGPoint
    
    init(colors: [CGColor], startPoint: CGPoint, endPoint: CGPoint) {
        self.colors = colors
        self.startPoint = startPoint
        self.endPoint = endPoint
        
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        applyGradient(colors: self.colors, startPoint: self.startPoint, endPoint: self.endPoint)
    }
    
    private func applyGradient(colors : [CGColor] , startPoint : CGPoint , endPoint : CGPoint) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint

        layer.insertSublayer(gradientLayer, at: 0)
    }
}

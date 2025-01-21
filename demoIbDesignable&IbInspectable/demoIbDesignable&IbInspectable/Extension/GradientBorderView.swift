//
//  File.swift
//  demoIbDesignable&IbInspectable
//
//  Created by apple on 22/05/24.
//

import Foundation
import UIKit

class GradientBorderView: UIView {
    
    // Properties for gradient background and border
    private var colorsBackground: [UIColor] = []
    private var colorsBorder: [UIColor] = []
    
    // Border and corner properties
    var borderWidthValue: CGFloat = 1 {
        didSet {
            setNeedsLayout()
        }
    }
    var cornerRadiusValue: CGFloat = 10 {
        didSet {
            layer.cornerRadius = cornerRadiusValue
            gradientLayer.cornerRadius = cornerRadiusValue
            borderLayer.cornerRadius = cornerRadiusValue
            setNeedsLayout()
        }
    }
    
    // Gradient layers
    private let gradientLayer = CAGradientLayer()
    private let borderLayer = CAGradientLayer()
    
    // Initializer
    init(frame: CGRect, colorsBackground: [UIColor], colorsBorder: [UIColor]) {
        super.init(frame: frame)
        self.colorsBackground = colorsBackground
        self.colorsBorder = colorsBorder
        setupLayers()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayers()
    }
    
    // Setup the gradient layers
    private func setupLayers() {
        // Background gradient
        gradientLayer.colors = colorsBackground.map { $0.cgColor }
        gradientLayer.frame = bounds
        gradientLayer.cornerRadius = cornerRadiusValue
        layer.insertSublayer(gradientLayer, at: 0)
        
        // Border gradient
        borderLayer.colors = colorsBorder.map { $0.cgColor }
        borderLayer.frame = bounds
        borderLayer.cornerRadius = cornerRadiusValue
        borderLayer.mask = createBorderMaskLayer()
        layer.addSublayer(borderLayer)
    }
    
    // Create a mask layer for the border
    private func createBorderMaskLayer() -> CALayer {
        let maskLayer = CAShapeLayer()
        let maskPath = UIBezierPath(roundedRect: bounds.insetBy(dx: borderWidthValue / 2, dy: borderWidthValue / 2), cornerRadius: cornerRadiusValue)
        maskLayer.path = maskPath.cgPath
        maskLayer.fillColor = UIColor.black.cgColor
        maskLayer.strokeColor = UIColor.black.cgColor
        maskLayer.lineWidth = borderWidthValue
        maskLayer.frame = bounds
        return maskLayer
    }
    
    // Layout subviews
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
        borderLayer.frame = bounds
        borderLayer.mask = createBorderMaskLayer()
    }
}

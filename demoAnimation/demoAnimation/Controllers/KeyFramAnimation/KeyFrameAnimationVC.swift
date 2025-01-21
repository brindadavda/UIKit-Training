//
//  KeyFrameAnimationVC.swift
//  demoAnimation
//
//  Created by apple on 18/04/24.
//

import UIKit

class KeyFrameAnimationVC: UIViewController {
    
    static let storyboardidentifier = "KeyFrameAnimationVC"
    
    @IBOutlet weak var animatedView: UIView!
    
    let pi = 3.14

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
   
    @IBAction func keyFramAnimation(_ sender: UIButton) {
        createKeyframeAnimation()
    }
    
    @IBAction func positionAnimation(_ sender: UIButton) {
        createPositionAnimation()
    }
    
    
    @IBAction func opacityAnimation(_ sender: UIButton) {
        createOpacityAnimation()
    }
    
    
    @IBAction func rotationAnimation(_ sender: UIButton) {
        createRotationAnimation()
    }
    
    
    @IBAction func complexPathAnimation(_ sender: UIButton) {
        createComplexPathAnimation()
    }
    

    func createKeyframeAnimation() {
        let animation = CAKeyframeAnimation(keyPath: "position")
        
        // Define the path the UIView will follow
        let path = UIBezierPath()
        path.move(to: animatedView.center)
        path.addQuadCurve(to: CGPoint(x: 100, y: 100), controlPoint: CGPoint(x: 500, y: 200))
        
        animation.path = path.cgPath
        animation.duration = 2.0
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
        // Scale the view while animating
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = 1.5
        scaleAnimation.toValue = 0.5
        scaleAnimation.duration = 2.0
        
        // Group both animations
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [animation, scaleAnimation]
        groupAnimation.duration = 2.0
        
        // Apply the animations to the UIView
        animatedView.layer.add(groupAnimation, forKey: "positionAndScale")
    }
    
    
    func createPositionAnimation() {
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.values = [
            CGPoint(x: view.center.x, y: 0),
            CGPoint(x: view.center.x, y: view.bounds.height / 2),
            CGPoint(x: view.center.x, y: view.bounds.height)
        ].map { NSValue(cgPoint: $0) }
        animation.duration = 1.5
        animatedView.layer.add(animation, forKey: "positionAnimation")
    }
    
    
    func createRotationAnimation() {
        let animation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        animation.values = [0, pi, pi * 2]
        animation.duration = 2.0
        animatedView.layer.add(animation, forKey: "rotationAnimation")
    }
    
    func createOpacityAnimation() {
        let animation = CAKeyframeAnimation(keyPath: "opacity")
        animation.values = [1.0, 0.5, 0.0]
        animation.duration = 2.0
        animatedView.layer.add(animation, forKey: "opacityAnimation")
    }
    
    
    func createComplexPathAnimation() {
        animatedView.frame.size.width = 50
        animatedView.frame.size.height = 50
        let subView = UIView()

        subView.frame = CGRect(origin: animatedView.frame.origin, size: CGSize(width: Int.random(in: 100...200), height: Int.random(in: 100...200)))
        subView.backgroundColor = .random
        animatedView.addSubview(subView)
        
        let animation = CAKeyframeAnimation(keyPath: "position")
          let path = UIBezierPath()
          path.move(to: CGPoint(x: 0, y: 0))
          path.addCurve(to: CGPoint(x: subView.bounds.width, y: 0), controlPoint1: CGPoint(x: Int.random(in: 100...200), y:  Int.random(in: 100...200)), controlPoint2: CGPoint(x: Int.random(in: 100...200), y: -Int.random(in: 100...200)))
        path.addCurve(to: CGPoint(x: 0, y: 0), controlPoint1: CGPoint(x: Int(subView.bounds.width) -  100, y: -Int.random(in: 100...200)), controlPoint2: CGPoint(x: Int(subView.bounds.width) -  100, y:  Int.random(in: 100...200)))
          animation.path = path.cgPath
          animation.duration = 4.0
        subView.layer.add(animation, forKey: "complexPathAnimation")
    }
}

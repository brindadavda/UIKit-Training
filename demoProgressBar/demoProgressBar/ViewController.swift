//
//  ViewController.swift
//  demoProgressBar
//
//  Created by apple on 16/01/24.
//

import UIKit

class ViewController: UIViewController {
    
    let movePoint = CGPoint(x: 70, y: 100)
    let progressLayer = CAShapeLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        let customeShape = CustomeSnakShap(radius: 60, movePoint: movePoint)
        let shapeLayer = customeShape.getCustomeShape()
      
        view.layer.addSublayer(shapeLayer)
       
        progressLayer.path = shapeLayer.path
        progressLayer.strokeColor = UIColor.systemBlue.cgColor
        progressLayer.lineWidth = 5
        progressLayer.fillColor = nil
//        progressLayer.lineCap = .round
        //progressLayer.strokeEnd = 0.0 // Initial progress (0%)
        
        //logic for
        view.layer.addSublayer(progressLayer)
        
        //adding button
        let button = UIButton();
        button.backgroundColor = UIColor.systemGray
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.frame = CGRect(x: UIScreen.main.bounds.width/2 ,  y: UIScreen.main.bounds.height - 100, width: 100, height: 50)
        
        button.addTarget(self, action: #selector(actionIncrementProgress), for: .allTouchEvents)
        
        self.view.addSubview(button)
        
    }
    
    var count : Double  = 0
    
    @objc func actionIncrementProgress(){
        count += 0.01
        
        // Animate progress bar
        UIView.animate(withDuration: 1.0) {
            self.progressLayer.strokeEnd = CGFloat(self.count)
        }
    }


}


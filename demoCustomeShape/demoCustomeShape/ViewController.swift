//
//  ViewController.swift
//  demoCustomeShape
//
//  Created by apple on 24/02/24.
//

import UIKit

class ViewController: UIViewController {
    
    let movePoint = CGPoint(x: 70, y: 100)
    let progressLayer = CAShapeLayer()
    
    @IBOutlet weak var bottomBarView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        let customeShape = CustomeShap(radius: 60, movePoint: movePoint)
        let shapeLayer = customeShape.getCustomeShape()
      
        view.layer.addSublayer(shapeLayer)
       
        progressLayer.path = shapeLayer.path
        progressLayer.strokeColor = UIColor.systemBlue.cgColor
        progressLayer.lineWidth = 5
        progressLayer.fillColor = nil
        progressLayer.lineCap = .round
        //progressLayer.strokeEnd = 0.0 // Initial progress (0%)
        
        //logic for
        //view.layer.addSublayer(progressLayer)
        
        //adding button
        let button = UIButton();
        button.backgroundColor = UIColor.systemGray
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.frame = CGRect(x: UIScreen.main.bounds.width/2 ,  y: UIScreen.main.bounds.height - 100, width: 100, height: 50)
        
        button.addTarget(self, action: #selector(actionIncrementProgress), for: .allTouchEvents)
        
        self.view.addSubview(button)
        
        let customeshape =  CustomBottombar(radius: 20, movePoint: CGPoint(x: 10, y: view.bounds.height - bottomBarView.bounds.height - 30) , width: 120 , height: bottomBarView.bounds.height).getCustomeShape()
        
        self.view.layer.addSublayer(customeshape)
        
        setCustomBottomBar()
        
    }
    
    var count : Double  = 0
    
    @objc func actionIncrementProgress(){
        count += 0.01
        
        // Animate progress bar
        UIView.animate(withDuration: 1.0) {
            self.progressLayer.strokeEnd = CGFloat(self.count)
        }
    }
    
    func setCustomBottomBar(){
        
        //let customeshape =  CustomBottombar(radius: bottomBarView.bounds.height, movePoint: CGPoint(x: 0, y: 0))
        
        print("View Controller : ---> ")
        print(bottomBarView.bounds.height/3,   0, view.bounds.height - bottomBarView.bounds.height)
        
        //bottomBarView.layer.addSublayer(customeshape)
    }


}




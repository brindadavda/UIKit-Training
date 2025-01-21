//
//  ViewController.swift
//  demoAnimation
//
//  Created by apple on 04/03/24.
//

import UIKit
import Lottie

class ViewController: UIViewController {
    
    //create animation variable
    private var animationView: LottieAnimationView?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .lightGray
        
        animationView?.backgroundColor = .cyan
        
//        animationView = .init(name: "coffee")
        animationView = .init(name: "heart")
        let subView = UIView(frame: CGRect(x:view.bounds.width/2 - 100 , y: view.bounds.height/2 - 100, width: 200, height: 200))
         
        subView.backgroundColor = .cyan
        subView.layer.cornerRadius = subView.bounds.height/2
        
        
        
        animationView!.frame = CGRect(origin: CGPoint(x: subView.bounds.width/2 - 75, y: subView.bounds.height/2 - 75), size: CGSize(width: 150, height: 150))
        
        animationView?.layer.cornerRadius = animationView!.bounds.height/2
         
         // 3. Set animation content mode
         
        animationView!.contentMode = .scaleAspectFill
        animationView?.backgroundColor = .lightGray
         
         // 4. Set animation loop mode
         
         animationView!.loopMode = .loop
         
         // 5. Adjust animation speed
         
        animationView!.animationSpeed = 0.8
        
        subView.addSubview(animationView!)
         
        view.addSubview(subView)
        
        
         
         // 6. Play animation
         
         animationView!.play()
        
    }


}


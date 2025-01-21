//
//  AnimationVC.swift
//  demoAnimation
//
//  Created by apple on 04/03/24.
//

import UIKit

class AnimationVC: UIViewController {
    
    @IBOutlet weak var button: UIButton!
    
    @IBOutlet weak var button2: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let newButtonWidth: CGFloat = 30
        
        UIView.animate(withDuration: 9.0, //1
            delay: 0.9, //2
            usingSpringWithDamping: 3.0, //3
            initialSpringVelocity: 5, //4
                       options: .curveLinear, //5
            animations: ({ //6
            self.button.frame = CGRect(x: 200, y: 200, width: newButtonWidth, height: newButtonWidth)
                self.button.center = self.view.center
        }), completion: nil)
        
        UIView.animate(withDuration: 8.0, delay: 0.0,
                       options: .repeat , animations: {
            
            self.button.frame = CGRect(x: 200, y: 200, width: newButtonWidth, height: newButtonWidth)
            self.button.backgroundColor = .random
            self.button.layer.cornerRadius = self.button.bounds.height/2
            self.button.layer.borderWidth = .random(in: 30...50)
            self.button.layer.borderColor = UIColor.random.cgColor
           self.button.center = self.view.center
        })
        
        
        UIView.animate(withDuration: 9.0, //1
            delay: 0.9, //2
            usingSpringWithDamping: 3.0, //3
            initialSpringVelocity: 5, //4
                       options: .curveLinear, //5
            animations: ({ //6
            self.button2.frame = CGRect(x: 0, y: 300, width: newButtonWidth, height: newButtonWidth)
               
        }), completion: nil)
        
        UIView.animate(withDuration: 8.0, delay: 0.0,
                       options: .repeat , animations: {
            
            //self.button2.frame = CGRect(x: 200, y: 200, width: newButtonWidth, height: newButtonWidth)
            self.button2.backgroundColor = .random
            self.button2.layer.cornerRadius = self.button.bounds.height/2
            self.button2.layer.borderWidth = .random(in: 30...50)
            self.button2.layer.borderColor = UIColor.random.cgColor
           self.button2.center = self.view.center
        })
    
        view.addSubview(button)
    }
    
    

}


extension UIColor {
    static var random: UIColor {
        return UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 0.5
        )
    }
}

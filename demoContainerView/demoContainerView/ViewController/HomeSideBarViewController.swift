//
//  HomeSideBarViewController.swift
//  demoContainerView
//
//  Created by apple on 10/01/24.
//

import UIKit


//creating protocol like work
protocol onTapDelegate : class{
    func ontap()->Bool
}

class HomeSideBarViewController: UIViewController , onTapDelegate {
    
    
    //on tap delegate function working
    func ontap() -> Bool {
        return true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //creating object of homeClass
        //object of
        var homeVCObject = HomeViewController()
        homeVCObject.delegate = self
        
        let recognizer = UITapGestureRecognizer(target: self,
                                                action: #selector(onTapGesture(_ :)))
        
        self.view.addGestureRecognizer(recognizer)
        
    }
    
    
    //on tap side bar close
    @objc func onTapGesture(_ tap: UITapGestureRecognizer){
        //while tap hide side view
        
        self.view.superview?.isHidden = true
    }
    
    

}

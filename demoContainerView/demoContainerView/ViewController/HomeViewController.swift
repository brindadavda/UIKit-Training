//
//  HomeViewController.swift
//  demoContainerView
//
//  Created by apple on 10/01/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    //on tap
    var onTapSidebar = true
    
    var delegate : onTapDelegate?
    
    
    //on tap side bar close
    /*@objc func onTapGesture(_ tap: UITapGestureRecognizer){
        //while tap hide side view
        settingsContainerVIew.isHidden = true
        onTapSidebar = true
        
        print("HomeVC : \(#function)")
    }*/
    
    
    //menu button
    @IBAction func actionOpenSideBar(_ sender: UIButton) -> Void  {
        //open sidebar while clicking on menu button
        /*if onTapSidebar == true{
            let recognizer = UITapGestureRecognizer(target: self,
                                                    action: #selector(onTapGesture(_ :)))
            
            settingsContainerVIew.addGestureRecognizer(recognizer)
            settingsContainerVIew.isHidden = false
            onTapSidebar = false
        }*/
        
        
        /*if settingsContainerVIew.isHidden == true {
            settingsContainerVIew.isHidden = false
        }else{
            settingsContainerVIew.isHidden = true
        }*/
        
       guard let isHide = delegate?.ontap() else{
           //show side view
           settingsContainerVIew.isHidden = false
            return ;
        }
        
        //hide sideView controller
        settingsContainerVIew.isHidden = true
        

    }
    
    @IBOutlet weak var settingsContainerVIew: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //initialy container show
        
    }

   

}

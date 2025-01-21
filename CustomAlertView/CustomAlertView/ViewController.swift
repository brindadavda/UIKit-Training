//
//  ViewController.swift
//  CustomAlertView
//
//  Created by apple on 05/07/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var viewAlert : UIView!
    
    var alert : CustomAlertView?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        

            //create button
        let btn = UIButton(frame: CGRect(x:100,y:100,width:200,height:60))
        btn.setTitle("Show Alert", for: .normal)
        btn.backgroundColor = .cyan
        btn.clipsToBounds = true
        view.addSubview(btn)
        
        btn.addTarget(self, action: #selector(btnActionController(_:)), for: .touchUpInside)
        
       
        
    }

    @objc func btnActionController(_ sender : UIButton){
        viewAlert.isHidden = false
        setUpSingleAlert()
        alert?.showAlert(view: viewAlert, alertType: .doubleAlertAction)
    }

    
    func setUpSingleAlert(){
        let cancleAction = Actions(completion: ({
            self.viewAlert.isHidden = true
        }), title: "Cancle", style: .destructive, sucess : false)
        
        let okAction = Actions(completion: ({
            self.viewAlert.isHidden = true
        }), title: "Ok", style: .default , sucess : true)
        
        alert = CustomAlertView(title: "Are you sure?", message: "Press Cancle to dissmiss alert.", actions: [okAction,cancleAction], target: self)
    }
}




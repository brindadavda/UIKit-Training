//
//  LoginVC.swift
//  instagramClone
//
//  Created by apple on 22/02/24.
//

import UIKit

class LoginVC: UIViewController {
    @IBOutlet weak var passwordTF: DesignableUITextField!
    
    @IBOutlet weak var emailTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func loginAction(_ sender: UIButton) {
        Task {
            if let email = emailTF.text , let passWord = passwordTF.text{
                
                if await FirebaseDB.shared.loginUser(email: email, password: passWord){
                    DisplayAlert(AlertType: Alert.Success.rawValue, message: "SuccessFully Login", target: self)
                }else{
                    DisplayAlert(AlertType: Alert.Error.rawValue, message: "Found Error while Login", target: self)
                }
                
            }
        }
    }
}

//
//  RegisterPasswordVC.swift
//  instagramClone
//
//  Created by apple on 23/02/24.
//

import UIKit

class RegisterPasswordVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBOutlet weak var userPasswordTF: UITextField!
    
    @IBAction func updatePassword(_ sender: UIButton) {
        Task {
            if let password = userPasswordTF.text , !userPasswordTF.text!.isEmpty  {
                if await FirebaseDB.shared.updatePassword(password: password){
                    DisplayAlert(AlertType: Alert.Success.rawValue, message: "Successfully added password", target: self)
                }
                else {
                    DisplayAlert(AlertType: Alert.Error.rawValue, message: "Error while register password", target: self)
                }
            }
            else {
                DisplayAlert(AlertType: Alert.Error.rawValue, message: "Please provide the valid password", target: self)
            }
            
        }
    }

}

//
//  ChooseUsernameVC.swift
//  instagramClone
//
//  Created by apple on 22/02/24.
//

import UIKit

class ChooseUsernameVC: UIViewController {

    @IBOutlet weak var usernameTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func sendDataToFirebaseDB(_ sender: UIButton)  {
        if let username = usernameTF.text{
            Task{
                let user = User(username: username , phoneNumber: nil)
                if await FirebaseDB.shared.updateUser(user: user){
                    DisplayAlert(AlertType: Alert.Success.rawValue, message: "Username Added", target: self)
                }else{
                    DisplayAlert(AlertType: Alert.Success.rawValue, message: "Error whil  Adding username", target: self)
                }
            }
        }
    }

}

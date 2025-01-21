//
//  RegisterEmailVC.swift
//  instagramClone
//
//  Created by apple on 22/02/24.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase // Firebase Realtime Database

class RegisterEmailVC: UIViewController {

    @IBOutlet weak var userEmailTF: DesignableUITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
        //Firebase Work , Register user data to authentication in firebase
            
            //login user
            /*auth.signIn(withEmail: "dummy@gmail.com", password : "123456"){ (user, error) in
                if let error = error {
                    print(error.localizedDescription)
                }
                else if let user = user {
                    print("RegisterVC :---> user.user.uid : ---> \(user.user.uid)")
                }
            }
            
            if auth.currentUser != nil {
                var ref: DatabaseReference!
                ref = Database.database().reference()

                
                ref.child("users").child(auth.currentUser!.uid).setValue(["username": "any"]){
                    (error:Error?, ref:DatabaseReference) in
                    if let error = error {
                      print("Data could not be saved: \(error).")
                    } else {
                      print("Data saved successfully!")
                    }
                  }
                
                DisplayAlert(AlertType: Alert.Success.rawValue, message: "Current User : \(auth.currentUser)", target: self)

                
                    } else {
                      
                        DisplayAlert(AlertType: Alert.Error.rawValue, message: "Could not get current user", target: self)
                        
            }*/
        
    }
    
    
    @IBAction func sendEmailSucessScreen(_ sender: UIButton) {
        Task { 
            if let email = userEmailTF.text , !userEmailTF.text!.isEmpty  {
                //example : .createUser(email: "dummy@gmail.com", password: "123456")
                if await FirebaseDB.shared.createUser(email:email, password: "123456"){
                    DisplayAlert(AlertType: Alert.Success.rawValue, message: "Successfully register user", target: self)
                }
                else {
                    DisplayAlert(AlertType: Alert.Error.rawValue, message: "Error while register user", target: self)
                }
            }
            else {
                DisplayAlert(AlertType: Alert.Error.rawValue, message: "Please provide the valid email", target: self)
            }
            
        }
    }
    
    
    deinit{
        debugPrint("RegisterVC is released from memory")
    }
}

//
//  ViewController.swift
//  demoKeyChain
//
//  Created by apple on 23/02/24.
//

import UIKit
import Security


class ViewController: UIViewController {
    
    
    @IBOutlet weak var tfUsername: UITextField!
    
    @IBOutlet weak var tfPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Set username and password
//        let username = "username123"
//        let password = "password".data(using: .utf8)!
       
        
        
 
    }
    
    
    @IBAction func exitBtnClicked(_ sender: UIButton) {
        exitApp()
    }
    
    private func exitApp(){
        UIView.animate(withDuration: 0.1,
                   delay: 0.1,
                       options: UIView.AnimationOptions.curveEaseInOut,
                   animations: { () -> Void in
            
                           self.view?.layoutIfNeeded()
            }, completion: { (finished) -> Void in
            exit(-1)
            })
    }
    
    
    @IBAction func createUserBtnClicked(_ sender: UIButton) {
        let username = tfUsername.text ?? "username123"
        let password = tfPassword.text?.data(using: .utf8) ?? "password".data(using: .utf8)!
        
        Keychain.shared.saveData(username: username, password: password)
    }
    
    
    @IBAction func readUserBtnClicked(_ sender: UIButton) {
        let username = tfUsername.text ?? "username123"
        let password = tfPassword.text?.data(using: .utf8) ?? "password".data(using: .utf8)!
        Keychain.shared.retriveData(username: username)
    }
    
    
    @IBAction func updateUserBtnClicked(_ sender: UIButton) {
        let username = tfUsername.text ?? "username123"
        let password = tfPassword.text?.data(using: .utf8) ?? "password".data(using: .utf8)!
        Keychain.shared.updateData(username: username, updatedUser: User(id: UUID(), username: username, password: "newPassword".data(using: .utf8)!))
    }
    
    
    @IBAction func deleteUserBtnClicked(_ sender: UIButton) {
        let username = tfUsername.text ?? "username123"
        let password = tfPassword.text?.data(using: .utf8) ?? "password".data(using: .utf8)!
        Keychain.shared.deleteUser(username: username)
    }
    
    

}


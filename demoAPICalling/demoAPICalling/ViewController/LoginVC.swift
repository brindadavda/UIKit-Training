//
//  LoginVC.swift
//  demoAPICalling
//
//  Created by apple on 05/02/24.
//

import UIKit
import Alamofire

class LoginVC: UIViewController {
    
    @IBOutlet weak var userNameTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var tokenTF: UITextField!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var login: UIButton!
    
    
    @IBAction func loginUser(_ sender: UIButton) {
        resultLabel.text = "Login Sucessfully"
    }
    
    @IBAction func getUserData(_ sender: UIButton) {
        if let username = userNameTF.text , let password = passwordTF.text{
            
//            getLoginResultFromAPI(url: "https://dummyjson.com/auth/login" , userName: username , password: password)
            getLoginResultFromAPI(url: "https://dummyjson.com/users/1" , userName: username , password: password)
        }
    }
    
    
    @IBAction func postUserData(_ sender: UIButton) {
        if let username = userNameTF.text , let password = passwordTF.text,let token = tokenTF.text{
            addUserData(url: "https://dummyjson.com/users/add" , token : token)
        }
    }
    
    @IBAction func updateUser(_ sender: UIButton) {
        if let username = userNameTF.text , let password = passwordTF.text{
            updateUserData(url: "https://dummyjson.com/users/1" , username: username,password: password)
        }
    }
    
    
    @IBAction func deleteUserData(_ sender: UIButton) {
        AF.request("https://dummyjson.com/users/1",method: .delete).responseJSON(completionHandler: {response in switch(response.result){
        case .success(let data) :
            debugPrint(response)
            self.resultLabel.text = "Delete SuccessFully!"
            break
        case .failure(let error) :
            self.resultLabel.text = "Invalid credentials"
            break
        }
            
        })
    }
    
    
    func updateUserData(url : String , username : String , password : String){
        let parameter : Parameters = ["username" : username,"password" : password]
        let headers : HTTPHeaders = [.contentType("application/json")]
        
        AF.request(url , parameters: parameter , headers: headers ).responseJSON(completionHandler: {
            response in switch(response.result){
            case .success(let data) :
                debugPrint(response)
                self.resultLabel.text = "Data : \(data)"
                break
            case .failure(let error) :
                self.resultLabel.text = "Invalid credentials"
                break
            }
        })
    }
    
    func addUserData(url: String , token : String){
        let headers : HTTPHeaders = [.contentType("application/json")
                                     
            ]
        let parameter : Parameters = ["firstName": "Muhammad",
                                                                                              "lastName": "Ovi",
                                                                                              "age": "250",]
        
        AF.request(url, method: .post,parameters: parameter,headers: headers ).responseString(completionHandler: {
            response in switch(response.result){
            case .success(let data) :
                debugPrint(response)
                self.resultLabel.text = "Data : \(data)"
                break
            case .failure(let error) :
                self.resultLabel.text = "Invalid credentials"
                break
            }
        })
    }
    
    //login user
    func getLoginResultFromAPI(url : String , userName : String , password : String){
        let headers: HTTPHeaders = [
            .authorization(username: userName, password: password),
            .accept("application/json")
        ]
        
        let parameters : Parameters = ["username" : userName , "password" : password]
        
        AF.request(url,
                   method: .get,
                   parameters: parameters,
                   headers: headers).responseJSON(completionHandler: {
            response in
            switch(response.result){
            case .success(let data) :
                debugPrint(response)
                self.resultLabel.text = "Data : \(data)"
                break
            case .failure(let error) :
                self.resultLabel.text = "Invalid credentials"
                break
            }
        })
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelDidGetTapped))

        resultLabel.isUserInteractionEnabled = true
        resultLabel.addGestureRecognizer(tapGesture)
    }
    
    @objc
    func labelDidGetTapped(sender: UITapGestureRecognizer) {
        guard let label = sender.view as? UILabel else {
            return
        }
        UIPasteboard.general.string = label.text
    }
}

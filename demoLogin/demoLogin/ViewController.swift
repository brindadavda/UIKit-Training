//
//  ViewController.swift
//  demoLogin
//
//  Created by apple on 02/02/24.
//

import UIKit
// Add this to the header of your file, e.g. in ViewController.swift
import FacebookLogin
import FBSDKLoginKit
import GoogleSignIn

class ViewController: UIViewController {

    @IBOutlet weak var loginButtonWithFacebook: FBLoginButton!
    
    @IBAction func loginWithFacebook(_ sender: UIButton) {
        //check for facebook and google  not  login
        if  AccessToken.current != nil {
            // Do any additional setup after loading the view
            if let token = AccessToken.current,
                    !token.isExpired {
                    // User is logged in, do work such as go to next view controller.
                GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, email"]).start(completionHandler: { (connection, result, error) -> Void in
                      if (error == nil){
                          let fbDetails = result as! NSDictionary
                          print("ViewController : \(#function) : ---> Result : \(fbDetails)")
                      }else{
                          print(error?.localizedDescription ?? "Not found")
                      }
                  })
                }
            else{
                // Extend the code sample from 6a. Add Facebook Login to Your Code
                // Add to your viewDidLoad method:
                loginButtonWithFacebook.permissions = ["public_profile", "email"]
                loginButtonWithFacebook.delegate = self
            }
        }
       
    }
    
    @IBAction func loginWithGoogle(_ sender: UIButton) {
        
        //check for facebook and google not login
        if AccessToken.current == nil && !GIDSignIn.sharedInstance.hasPreviousSignIn() {
            // logged in with google
            GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
               guard error == nil else { return }

               // If sign in succeeded, display the app's main content View.
                guard let signInResult = signInResult else { return }

                   let user = signInResult.user

                   let emailAddress = user.profile?.email

                   let fullName = user.profile?.name
                   let givenName = user.profile?.givenName
                   let familyName = user.profile?.familyName

                   let profilePicUrl = user.profile?.imageURL(withDimension: 320)
                
                print("View Controller : ---> \(#function) ---> : data : ---> user : \(String(describing: fullName)) , \(String(describing: givenName)) , \(String(describing: familyName)) , \(profilePicUrl) ")
             }
           
        }
        //check for facebook  login
        else {
            // not logged in in google
            //show alert for it
            let alertController = UIAlertController(title: "Already Login", message: nil, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "ok", style: .default)
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true)
            
        }
        
       
    }
    
    @IBAction func signOut(sender: UIButton) {
        //check google login if yes then sign out
        if GIDSignIn.sharedInstance.hasPreviousSignIn(){
            GIDSignIn.sharedInstance.signOut()
            
            let alertController = UIAlertController(title: "Logout Successfully", message: nil, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "ok", style: .default)
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true)
            
        }else{
            let alertController = UIAlertController(title: "Please Login with google", message: nil, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "ok", style: .default)
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    


}

extension ViewController : LoginButtonDelegate {
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        
        //print("View Controller: ---> \(request)")
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("View Controller: ---> \(#function)")
    }
}

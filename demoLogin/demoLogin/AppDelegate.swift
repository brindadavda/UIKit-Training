//
//  AppDelegate.swift
//  demoLogin
//
//  Created by apple on 02/02/24.
//

// AppDelegate.swift
import UIKit
import FacebookCore
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
) -> Bool {
    
    GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
        if error != nil || user == nil {
          // Show the app's signed-out state.
        } else {
          // Show the app's signed-in state.
        }
      }
    
    // Create Google Sign In configuration object.
    let config = GIDConfiguration(clientID: clientID) // put your client id of google here
    
    GIDSignIn.sharedInstance.configuration = config
    
    // for facebook
   // ApplicationDelegate.shared.application(
   //     application,
   //     didFinishLaunchingWithOptions: launchOptions
   // )
    
   
    return true
}
      
func application(
    _ app: UIApplication,
    open url: URL,
    options: [UIApplication.OpenURLOptionsKey : Any] = [:]
) -> Bool {
    
    
    
        var handled: Bool
        
          handled = GIDSignIn.sharedInstance.handle(url)
          if handled {
            return true
          }

      // Handle other custom URL types.

      // If not handled by this app, return false.
      return false
}
}

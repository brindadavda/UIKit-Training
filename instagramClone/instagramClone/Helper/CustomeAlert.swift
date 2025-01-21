//
//  CustomeAlert.swift
//  instagramClone
//
//  Created by apple on 22/02/24.
//

import UIKit

enum Alert : String{
    case Error = "Error"
    case Success = "Success"
}

class DisplayAlert{
    private let AlertType : String
    private let message : String
    private let target : UIViewController
    
    init(AlertType: String, message: String, target: UIViewController) {
        self.AlertType = AlertType
        self.message = message
        self.target = target
        
        showAlert()
    }
    
    func showAlert(){
        
        let alertController = UIAlertController(title: AlertType, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(okAction)
        
        target.present(alertController, animated: true)
    }
}

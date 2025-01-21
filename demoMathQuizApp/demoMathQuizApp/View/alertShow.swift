//
//  alertShow.swift
//  demoMathQuizApp
//
//  Created by apple on 30/01/24.
//

import UIKit

func showAlert(title : String , message : String) -> UIAlertController{
    
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
    //make options
    
    //1. ok option
    let optionOk = UIAlertAction(title: "Ok", style: .default)
    
    //add this two option
    alert.addAction(optionOk)
    
    alert.setValue(NSAttributedString(string: alert.title!, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.medium), NSAttributedString.Key.foregroundColor : UIColor.systemRed]), forKey: "attributedTitle")
    alert.setValue(NSAttributedString(string: alert.message!, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.light), NSAttributedString.Key.foregroundColor : UIColor.systemBlue]), forKey: "attributedMessage")
   
    return alert
}

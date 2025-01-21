//
//  CustomeView.swift
//  demoCoreData
//
//  Created by apple on 13/02/24.
//

import UIKit

extension UIView{
    
       @IBInspectable var cornerRadius:CGFloat {
           set {
               clipsToBounds = newValue > 0
               if UIDevice.current.userInterfaceIdiom == .pad{
                   layer.cornerRadius = 2*newValue
               }else{
                   layer.cornerRadius = newValue
               }
           }
           get {
               return layer.cornerRadius
           }
       }
    
}

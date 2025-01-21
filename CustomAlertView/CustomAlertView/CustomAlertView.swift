//
//  CustomAlertView.swift
//  CustomAlertView
//
//  Created by apple on 05/07/24.
//

import UIKit

struct Actions{
    var completion : (()->())? = nil
    var title : String = "Ok"
    var style : UIAlertAction.Style = .default
    var sucess : Bool = true
}


enum AlerType{
    case singleAlertAction
    case doubleAlertAction
    case threeeAlertAction
}


final class CustomAlertView {
    
    var title : String = "Custom Alert Title"
    var message : String = "Custome Alert Message!"
    var actions : [Actions]
    var target : UIViewController
    var view : UIView?
    
    
     init(title: String, message: String, actions: [Actions], target: UIViewController) {
        self.title = title
        self.message = message
        self.actions = actions
        self.target = target
    }
    
    
    func showAlert(view :  UIView , alertType : AlerType = .singleAlertAction){
        view.subviews.forEach({ $0.removeFromSuperview() })
    
        if alertType == .singleAlertAction{
            if let subView = setUpSingleAlertAction(view: view){
               // subView.alpha = 0.0
                
                
//                UIView.animate(withDuration: 0.2, delay: 0.1, options: .curveEaseOut , animations: {
//                    subView.alpha = 1.0
//                })
                
                UIView.animate(withDuration: 0.33, delay: 0.5, usingSpringWithDamping: 0.7, initialSpringVelocity: 10, options: UIView.AnimationOptions(rawValue: 0), animations: {
                    view.addSubview(subView)
                })
            }
        }else if alertType == .doubleAlertAction{
            if let subView = setUpDoubleAlertAction(view: view){
                subView.alpha = 0.0
                view.addSubview(subView)
                
                UIView.animate(withDuration: 0.2, delay: 0.1, options: .curveEaseOut , animations: {
                    subView.alpha = 1.0
                })
            }
        }else if alertType == .threeeAlertAction{
            if let subView = setUpThirdAlertAction(view: view){
                subView.alpha = 0.0
                view.addSubview(subView)
                
                UIView.animate(withDuration: 0.2, delay: 0.1, options: .curveEaseOut , animations: {
                    subView.alpha = 1.0
                })
            }
        }
        
    }
    
    
    
    func setUpSingleAlertAction(view : UIView) -> UIView?{
        if let subView = Bundle.nibView(AlertView1.self){
            subView.lblTitle.text = self.title
            subView.lblMessage.text = self.message
            subView.btnAction.setTitle(self.actions.first?.title, for: .normal)
            subView.frame = view.bounds
            subView.clipsToBounds = true
            subView.btnAction.addTarget(self, action: #selector(handleBtnClickController(_ : )), for: .touchUpInside)
            if let isSucess = self.actions.first?.sucess{
                subView.iv.image = isSucess ? UIImage(systemName: "checkmark") : UIImage(systemName: "xmark")
                subView.viewBg.backgroundColor = isSucess ? UIColor.green : UIColor.red
                subView.btnAction.backgroundColor = isSucess ? UIColor.green : UIColor.red
            }
           
            return subView
        }
        return nil
    }
    
    
    
    func setUpDoubleAlertAction(view : UIView) -> UIView? {
        if let subView = Bundle.nibView(AlertView2.self){
            subView.lblTitle.text = self.title
            subView.lblMessage.text = self.message
            
            if self.actions.indices.contains(0){
                subView.btnAction1.setTitle(self.actions[0].title, for: .normal)
                subView.btnAction1.backgroundColor = self.actions[0].sucess ? UIColor.green : UIColor.red
            }
            if self.actions.indices.contains(1){
                subView.btnAction2.backgroundColor = self.actions[1].sucess ? UIColor.green : UIColor.red
                subView.btnAction2.setTitle(self.actions[1].title, for: .normal)
            }
            
            if self.actions.count >= 2{
               
               
            }
            subView.frame = view.bounds
            subView.clipsToBounds = true
            subView.btnAction1.addTarget(self, action: #selector(handleBtnClickController(_ : )), for: .touchUpInside)
            subView.btnAction2.addTarget(self, action: #selector(handleSecoundBtnClickController(_ : )), for: .touchUpInside)
           
            return subView
        }
        return nil
    }
    
    
    
    func setUpThirdAlertAction(view : UIView) -> UIView? {
        if let subView = Bundle.nibView(AlertView3.self){
            subView.lblTitle.text = self.title
            subView.lblMessage.text = self.message
            if self.actions.indices.contains(0){
                subView.btnAction1.backgroundColor = self.actions[0].sucess ? UIColor.green : UIColor.red
                subView.btnAction1.setTitle(self.actions[0].title, for: .normal)
            }
            if self.actions.indices.contains(1){
                subView.btnAction2.backgroundColor = self.actions[1].sucess ? UIColor.green : UIColor.red
                subView.btnAction2.setTitle(self.actions[1].title, for: .normal)
            }
            if self.actions.indices.contains(2){
                subView.btnAction3.setTitle(self.actions[2].title, for: .normal)
                subView.btnAction3.backgroundColor = self.actions[2].sucess ? UIColor.green : UIColor.red
            }
            subView.frame = view.bounds
            subView.clipsToBounds = true
            subView.btnAction1.addTarget(self, action: #selector(handleBtnClickController(_ : )), for: .touchUpInside)
            subView.btnAction2.addTarget(self, action: #selector(handleSecoundBtnClickController(_ : )), for: .touchUpInside)
            subView.btnAction3.addTarget(self, action: #selector(handleThirdBtnClickController(_ : )), for: .touchUpInside)
           
            return subView
        }
        return nil
    }
    
    
    @objc func handleBtnClickController(_ sender : UIButton){
        self.actions.first?.completion?()
    }
    
    @objc func handleSecoundBtnClickController(_ sender : UIButton){
        if self.actions.indices.contains(1){
            self.actions[1].completion?()
        }
    }
    
    
    @objc func handleThirdBtnClickController(_ sender : UIButton){
        if self.actions.indices.contains(2){
            self.actions[2].completion?()
        }
    }
   

    
}



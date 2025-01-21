//
//  UIViewController+Extension.swift
//  ApplatchKids
//
//  Created by Mac on 10/01/24.
//

import UIKit

extension UIViewController {
    
    func addContainerView(subController controller:UIViewController, superView:UIView) {
        addChild(controller)
        superView.addSubview(controller.view)
        controller.view.frame = superView.bounds
        controller.didMove(toParent: self)
    }
    
    func configureNavigationBar(largeTitleColor: UIColor, backgoundColor: UIColor, tintColor: UIColor, title: String, preferredLargeTitle: Bool) {
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: largeTitleColor]
            navBarAppearance.titleTextAttributes = [.foregroundColor: largeTitleColor]
            navBarAppearance.backgroundColor = backgoundColor
            
            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.compactAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
            
            navigationController?.navigationBar.prefersLargeTitles = preferredLargeTitle
            navigationItem.largeTitleDisplayMode = .always
            navigationController?.navigationBar.isTranslucent = false
            navigationController?.navigationBar.tintColor = tintColor
            navigationItem.title = title
            
        } else {
            // Fallback on earlier versions
            navigationController?.navigationBar.barTintColor = backgoundColor
            navigationController?.navigationBar.tintColor = tintColor
            navigationController?.navigationBar.isTranslucent = false
            navigationItem.title = title
        }
    }
    
    func alert(title: String? = nil, message: String? = nil, preferredStyle: UIAlertController.Style = .alert, isAddConfirm:Bool = true, confirmActionTitle:String? = "Confirm", confirmActionStyle:UIAlertAction.Style? = .default, confirmAction: ((UIAlertAction) -> Void)? = nil, isAddCancel:Bool = true, cancelActionTitle:String? = "Cancel", cancelActionStyle:UIAlertAction.Style? = .default, cancelAction: ((UIAlertAction) -> Void)? = nil, alertActions: [UIAlertAction]? = nil, uiAlertController: ((UIAlertController) -> ())? = nil,  completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        let confirmAction = UIAlertAction(title: confirmActionTitle, style: confirmActionStyle ?? .default, handler: confirmAction)
        let cancelAction = UIAlertAction(title: cancelActionTitle, style: cancelActionStyle ?? .default, handler: cancelAction)
        
        if let actions = alertActions {
            for action in actions {
                alert.addAction(action)
            }
            if isAddConfirm == true {
                alert.addAction(confirmAction)
            }
            if isAddCancel == true {
                alert.addAction(cancelAction)
            }
        }else {
            if isAddConfirm == true {
                alert.addAction(confirmAction)
            }
            if isAddCancel == true {
                alert.addAction(cancelAction)
            }
        }
        
        uiAlertController?(alert)
        
        self.present(alert, animated: true, completion: completion)
    }
    
    func applyToolBar(textField:UITextField? = nil, textView:UITextView? = nil, isCancel:Bool, isNext:Bool) {
        let btnBarDone = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.toolbarDone))
        let btnBarNext = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(self.toolbarNext))
        let btnBarCancel = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.endEditing))
        let btnBarSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        var barItem = [UIBarButtonItem]()
        if isCancel == true {
            barItem.append(btnBarCancel)
        }
        barItem.append(btnBarSpace)
        if isNext == true {
            barItem.append(btnBarNext)
        }
        barItem.append(btnBarDone)
        toolbar.setItems(barItem, animated: true)
        toolbar.barTintColor = .white
        if let textfield = textField {
            textfield.delegate = self as? UITextFieldDelegate
            textfield.inputAccessoryView = toolbar
        }else if let textview = textView {
            textview.delegate = self as? UITextViewDelegate
            textview.inputAccessoryView = toolbar
        }
    }
    
    @objc func toolbarDone(){}
    
    @objc func toolbarNext() {}
    
    @objc func endEditing() {}

    @objc func datePicker(datePicker:UIDatePicker) {}
    
}


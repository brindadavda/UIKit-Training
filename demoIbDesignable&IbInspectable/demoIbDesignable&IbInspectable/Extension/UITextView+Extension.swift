//
//  UITextView+Extension.swift
//  ApplatchKids
//
//  Created by Mac on 10/01/24.
//

import UIKit

extension UITextView {
    
    func toolbarDone(_ viewController:UIViewController, isCancel:Bool = false, isNext:Bool = false) {
        viewController.applyToolBar(textView: self, isCancel: isCancel, isNext: isNext)
    }
    
    func removeAllSpacing() {
        self.textContainerInset = UIEdgeInsets.zero
        self.textContainer.lineFragmentPadding = 0
    }
}

//
//  UITextField+Extension.swift
//  ApplatchKids
//
//  Created by Mac on 10/01/24.
//

import UIKit

extension UITextField {
    
    @IBInspectable var placeholderColor : UIColor? {
        get {
            return self.placeholderColor
        }set {
            guard let color = newValue else { return }
            let placeholder = self.placeholder ?? ""
            self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor  : color])
        }
    }
}

extension UITextField {
    
    var text_:String {
        return (self.text ?? "")
    }
    
    func inputPicker(_ viewController:UIViewController, backGroundColor:UIColor = .white, complition: ((UIPickerView) -> ())? = nil) {
        self.delegate = self as? UITextFieldDelegate
        
        let pickerView = UIPickerView()
        pickerView.delegate = viewController as? UIPickerViewDelegate
        pickerView.backgroundColor = backGroundColor
        pickerView.sizeToFit()
        pickerView.isUserInteractionEnabled = true
        pickerView.dataSource = viewController as? UIPickerViewDataSource
        self.inputView = pickerView
        
        if let complition = complition {
            complition(pickerView)
        }
    }
    
    func toolbarDone(_ viewController:UIViewController, isCancel:Bool = false, isNext:Bool = false) {
        viewController.applyToolBar(textField: self, isCancel: isCancel, isNext: isNext)
    }
    
    @discardableResult
    func inputDatePicker(_ viewController:UIViewController, minimumDate:Date? = nil, maximumData:Date? = nil, mode:UIDatePicker.Mode = .date, timeZone:TimeZone? = .current, locale:Locale? = .current ,backGroundColor:UIColor = .white, complition: ((UIDatePicker) -> ())? = nil) -> UIDatePicker {
        let datePicker = UIDatePicker()
        datePicker.sizeToFit()
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = UIDatePickerStyle.wheels
        } else {
            
        }
        datePicker.backgroundColor = backGroundColor
        datePicker.datePickerMode = mode
        datePicker.minimumDate = minimumDate
        datePicker.maximumDate = maximumData
        datePicker.timeZone = timeZone
        datePicker.locale = locale
        datePicker.addTarget(viewController, action: #selector(viewController.datePicker), for: .valueChanged)
        self.inputView = datePicker
        
        if let complition = complition {
            complition(datePicker)
        }
        
        return datePicker
    }
}

//
//  CountrySelection.swift
//  instagramClone
//
//  Created by apple on 22/02/24.
//

import Foundation
import UIKit

extension RegisterVC : UIPickerViewDelegate , UIPickerViewDataSource, UITextFieldDelegate{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrOfCountriesWithTheirValues.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrOfCountriesWithTheirValues[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let countryCode = arrOfCountriesWithTheirValues[row].split(separator: " ")[2]
        
        phoneNumberTextField.text = String(countryCode)
    }

    func countryName(countryCode: String) -> String? {
        let current = Locale(identifier: "en_US")
        return current.localizedString(forRegionCode: countryCode)
    }

    func flag(country: String) -> String {
        let base : UInt32 = 127397
        var s = ""
        for v in country.unicodeScalars {
            s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
        }
        return String(s)
    }
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("CountrySelection :---> \(pickerView.isHidden)")
        if !pickerView.isHidden && !phoneNumberTextField.text!.isEmpty{
           return false
        }
        pickerView.isHidden = false
        return true
    }
}

//
//  RoundButton.swift
//  demoCalculator
//
//  Created by apple on 06/01/24.
//

import UIKit


@IBDesignable
class RoundButton: UIButton {
    
    @IBInspectable var roundButton : Bool = false{
        didSet{
            if roundButton{
                layer.cornerRadius = frame.height / 2
            }
        }
    }
    
    override func prepareForInterfaceBuilder() {
        if roundButton{
            layer.cornerRadius = frame.height / 2
        }    }

}

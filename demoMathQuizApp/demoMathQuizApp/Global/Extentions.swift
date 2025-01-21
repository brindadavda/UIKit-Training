//
//  Extention.swift
//  demoMathQuizApp
//
//  Created by apple on 01/02/24.
//

import UIKit

/* ------ extend the ui button start for deselect other button start ------ */
extension UIButton {
    func setOtherButtonsToFalse(in buttons: [UIButton]) {
        setButtonsToFalseExcept(self, buttons: buttons)
    }
}

/* ------ extend the ui button start for deselect other button end ------ */

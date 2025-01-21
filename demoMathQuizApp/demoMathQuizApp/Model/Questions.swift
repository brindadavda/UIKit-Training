//
//  Questions.swift
//  demoMathQuizApp
//
//  Created by apple on 30/01/24.
//

import UIKit

struct Question{
    var num1 : Int
    var num2 : Int
    var correctAns : Double
    var operand : OperationEnum!
    
    init(num1: Int, num2: Int, correctAns: Double, operand: OperationEnum) {
        self.num1 = num1
        self.num2 = num2
        self.correctAns = correctAns
        self.operand = operand
    }
}

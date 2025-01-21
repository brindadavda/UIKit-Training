//
//  functions.swift
//  demoMathQuizApp
//
//  Created by apple on 01/02/24.
//

import UIKit

/* ------- get time count based on range logic start ------ */
func getTimeCount(range : Int) -> Int{
    var result = 0
    switch range{
    case 1:
        result = 10
        break
    case 11:
        result = 20
        break
    case 21:
        result = 30
        break
    case 31:
        result = 40
        break
    case 41:
        result = 50
        break
        
    default:
        result = 0
    }

    return result
}
/* ------- get time count based on range logic end ------ */

/* ------- generate randome operation logic start ------ */
func generateRandomOperation(operations : String) -> OperationEnum{
   let randomeOperation = OperationEnum.allCases.randomElement()!
   if operations.contains(randomeOperation.rawValue){
       return randomeOperation
   }
  return generateRandomOperation(operations: operations)
}
/* ------- generate randome operation logic end ------ */

/* ------ get the two randome number  for num1 and num2 logic start ------ */
func generateTwoNum(from range : Int, to count : Int)-> (Int,Int){
    return (Int.random(in: range...count) , Int.random(in: range...count))
}
/* ------ get the two randome number logic end ------ */

/* ------ get the correct ans logic start ------ */
func getCorrectAns(num1 : Int ,  num2 : Int , opration : OperationEnum) -> Double{
    var result : Double!
    switch opration{
    case .Addition :
        result = Double(num1 + num2)
        break
    case .Subtraction :
        result = Double((num1 - num2))
        break
    case .Multiplication :
        result = Double(num1*num2)
        break
    case .Division :
        if num2 != 0{
            result = Double(num1/num2)
        }else{
            print("result is not valid")
        }
        break
    }
    return result
}
/* ------ get the correct ans logic end ------ */

/* -------  set other button selectde false logic for radio btn start ------ */
func setButtonsToFalseExcept(_ selectedButton: UIButton, buttons: [UIButton]) {
    for button in buttons {
        button.isSelected = button == selectedButton
    }
}
/* -------  set other button selectde false logic for radio btn end ------ */

/* ------ question generate function work start ------ */
func generateQuestion(totalQuestion count: Int , operations : String , range : Int) -> [Question]{
    var result = [Question]()
    for _ in 1...count{
        //generate two randome number
        let (num1 , num2) = generateTwoNum(from: range, to: range+10)
        let operation  = generateRandomOperation(operations: operations)
        let correctAns = getCorrectAns(num1: num1, num2: num2, opration: operation)
        let question = Question(num1: num1, num2: num2, correctAns: correctAns, operand: operation)
        result.append(question)
    }
    return result
}
/* ------ question generate function work end ------ */

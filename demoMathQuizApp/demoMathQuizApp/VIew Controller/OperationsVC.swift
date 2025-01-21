//
//  OperationsVC.swift
//  demoMathQuizApp
//
//  Created by apple on 29/01/24.
//

import UIKit

class OperationsVC: UIViewController {
    
    static let storyBoardIdentifier = "operationsVC"
    
    //get all the button for checkbox
    @IBOutlet weak var additionBtn: UIButton!
    @IBOutlet weak var subtractionBtn: UIButton!
    @IBOutlet weak var multiplicationBtn: UIButton!
    @IBOutlet weak var divisionBtn: UIButton!
    
    //result operation strin to store operation
    var result = ""
    
    //add the selected operation in result
    @IBAction func getOperation(_ sender: UIButton) {
        // sender tag : addition = 1 , subtraction = 2 , multiplication = 3 , division = 4
        switch sender.tag {
        case 1 : // addition
            if sender.isSelected {
                sender.isSelected = false
                result.replace(OperationEnum.Addition.rawValue, with: "")
            }else{
                sender.isSelected = true
                result += OperationEnum.Addition.rawValue
            }
            break
        case 2 : //subtraction
            if sender.isSelected {
                sender.isSelected = false
                result.replace(OperationEnum.Subtraction.rawValue, with: "")
            }else{
                sender.isSelected = true
                result += OperationEnum.Subtraction.rawValue
            }
            break
        case 3 : // multiplication
            if sender.isSelected {
                sender.isSelected = false
                result.replace(OperationEnum.Multiplication.rawValue, with: "")
            }else{
                sender.isSelected = true
                result += OperationEnum.Multiplication.rawValue
            }
            break
        case 4 : // division
            if sender.isSelected {
                sender.isSelected = false
                result.replace(OperationEnum.Division.rawValue, with: "")
            }else{
                sender.isSelected = true
                result += OperationEnum.Division.rawValue
            }
            break
        default : 
            print("OperationsVC : ----> no operation selected")
        }
        
    }
    
    @IBAction func goToNoOfQuestionsVC(_ sender: UIButton) {
        //set the value of result in oprtation string
        operations = result
        if !operations.isEmpty{
            let noOfquestionVC = storyboard?.instantiateViewController(identifier: NoOfQuestionVC.storyBoardIdentifier) as! NoOfQuestionVC
            navigationController?.pushViewController(noOfquestionVC, animated: true)
        }else{
            let alert = showAlert(title: "Empty Operation!", message: "Please Select the Operation")
            self.present(alert, animated: true)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }

    //when the back button pressed this view will disapper
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    deinit {
        print("Operations view controller's deinit called")
    }
}

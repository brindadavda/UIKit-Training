//
//  NoOfQuestionVC.swift
//  demoMathQuizApp
//
//  Created by apple on 29/01/24.
//

import UIKit

class NoOfQuestionVC: UIViewController {
    
    static let storyBoardIdentifier = "noOfQuestionVC"
    
    @IBOutlet weak var noOfQuestionTF: UITextField!
    
    @IBOutlet var bottomBtnCon: NSLayoutConstraint!
    
    @IBAction func goToTestVC(_ sender: UIButton) {
        let testVC = storyboard?.instantiateViewController(identifier: TestVC.STORY_BOARD_IDENTIFIER) as! TestVC
        let text : String = noOfQuestionTF.text!
        print("NoofQuestion : \(text)")
        if  !text.trimmingCharacters(in: .whitespaces).isEmpty && Int(text) != nil{
            //send it to noOfQuestionVariable
            noOfQuestions = Int(text)
        }else{
            let alert = showAlert(title: "Invalid Question no!" , message: "Please provide valid no of question")
            self.present(alert, animated: true)
        }
        navigationController?.pushViewController(testVC , animated: true)
    }
    
    @objc func keyboardWillShow(notification: Notification){
        //if keyboard show then
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue{
            bottomBtnCon.constant = keyboardSize.height
        }
        
    }
    
    @objc func keyboardWillHide(){
        bottomBtnCon.constant = 150
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //handle keyboard from notification observer
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardDidHideNotification, object: nil)
       
    }

    deinit {
        print("NoOfQuestion view controller's deinit called")
    }
}

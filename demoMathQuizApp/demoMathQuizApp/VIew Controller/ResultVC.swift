//
//  ResultVC.swift
//  demoMathQuizApp
//
//  Created by apple on 29/01/24.
//

import UIKit

class ResultVC: UIViewController{
    
    static let storyBoardIdentifier = "resultVC"
    
    //get the data from testVC
    var totalNoOfQuestion = 0
    var totalNoOfCorrectAns = 0
    
    var result : String = ""
    
    @IBOutlet weak var totalQuestionLabel: UILabel!
    
    @IBOutlet weak var totalCorrectAnsLabel: UILabel!
    
    @IBOutlet weak var totalWrongAnsLabel: UILabel!
    
    @IBOutlet weak var percentageLabel: UILabel!
    
    @IBOutlet weak var resultImg: UIImageView!
    
    @IBAction func gotoRangeVC(_ sender : UIButton){
        //navigate to root view pop all the view from navigation stack
        self.navigationController!.popToRootViewController(animated: true)
    }
    
    @IBAction func gotoTestVC(_ sender: Any) {
        let testVC = storyboard?.instantiateViewController(identifier: TestVC.STORY_BOARD_IDENTIFIER) as! TestVC
        
        self.navigationController?.pushViewController(testVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //set hidden navigation title
        navigationController?.navigationBar.isHidden = true
        
        totalQuestionLabel.text = "Total No. of Questions : \(totalNoOfQuestion)"
        totalCorrectAnsLabel.text = "Total No. of Right Ans : \(totalNoOfCorrectAns)"
        totalWrongAnsLabel.text = "Total No. of Wrong Ans : \(totalNoOfQuestion - totalNoOfCorrectAns)"
        
        result = String(format:"%.2f", ((Double(totalNoOfCorrectAns)/Double(totalNoOfQuestion))*100))
    
    
        percentageLabel.text = "Result is : \(result)%"
        
        //set the result image
        setResultImage()
    }
    
    func setResultImage(){
        guard let result = Double(result) else {
            return
        }
        
        if result >= 70{
            resultImg.image = UIImage(named: "smile")
        }
        else if result >= 45{
            resultImg.image = UIImage(named: "confused")
        }else{
            resultImg.image = UIImage(named: "sad")
        }
    }

    deinit {
        print("Result view controller's deinit called")
    }
}

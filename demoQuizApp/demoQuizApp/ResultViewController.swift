//
//  ResultViewController.swift
//  demoQuizApp
//
//  Created by apple on 08/01/24.
//

import UIKit

class ResultViewController: UIViewController {
    
    //creating variable
    var noCorrectAns = 0
    var noTotalQues = 0
    
    //declare variable
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var retryBtn: UIButton!
    
    @IBAction func ActionRetry(_ sender: UIButton) {
        performSegue(withIdentifier: "ViewController", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "ViewController"){
            let vc = segue.destination as! ViewController
            //set data to result screen
            vc.currentQuestionPos = 0
            vc.noCorrectQuestion = 0
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        resultLabel.text = "you got \(noCorrectAns) out of \(noTotalQues)"
        
        var percentRight = (Double(noCorrectAns) / Double(noTotalQues))*100
        
        if(percentRight < 40){
            titleLabel.text = "Not Good"
        }else if(percentRight < 70){
            titleLabel.text = "Good"
        }else{
            titleLabel.text = "Great Job!"
        }
    }
    

}

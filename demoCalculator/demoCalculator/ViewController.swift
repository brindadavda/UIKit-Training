//
//  ViewController.swift
//  demoCalculator
//
//  Created by apple on 06/01/24.
//

import UIKit

class ViewController: UIViewController {

    /*------ Calculator Work Start -------*/
    
    @IBOutlet weak var ResultLabel: UILabel!
    
    //calculation
    var numberOnScreen : Double = 0
    var previousNumber : Double = 0
    var performMath = false
    var operation = 0
    
    @IBAction func ActionBtnClicked(_ sender: UIButton) {
        //put your logic here while button click here
        
        if performMath == true{
            ResultLabel.text = String(sender.tag)
            numberOnScreen = Double(ResultLabel.text!)!
            performMath = false
        }else{
            ResultLabel.text = ResultLabel.text! + String(sender.tag)
            
            numberOnScreen = Double(ResultLabel.text!)!
        }
    }
    
    @IBAction func ActionCalculation(_ sender: UIButton) {
        //perform all the calculation here
        
        //tag 10 is equal and tag 15 is clear btn
        if ResultLabel.text != "" && sender.tag != 10 && sender.tag != 15{
            
            previousNumber = Double(ResultLabel.text!)!
            
            switch(sender.tag){
            case 11:
                //this is addition operation
                ResultLabel.text = "+"
                break;
            case 12:
                //subtraction operation perform
                ResultLabel.text = "-"
                break;
            case 13:
                //multiplication operation perform
                ResultLabel.text = "*"
                break;
            case 14:
                //division operation perform
                ResultLabel.text = "/"
                break;
            default:
                ResultLabel.text = "Operation not found"
            }
            
            operation = sender.tag
            performMath = true
            
        }
        
       
        
        print(operation)
        
        //if sender click on equal so tag will be 10
        if sender.tag == 10{
            switch(operation){
            case 11:
                //this is addition operation
                ResultLabel.text = String(numberOnScreen + previousNumber)
                break;
            case 12:
                //subtraction operation perform
                ResultLabel.text = String(previousNumber - numberOnScreen)
                break;
            case 13:
                //multiplication operation perform
                ResultLabel.text = String(previousNumber * numberOnScreen)
                break;
            case 14:
                //division operation perform
                ResultLabel.text = String(previousNumber / numberOnScreen)
                break;
            default:
                ResultLabel.text = "Operation not found"
            }
        }
        
        //if sender click on clear tag will be 15
        if sender.tag == 15{
            numberOnScreen = 0
            previousNumber = 0
            ResultLabel.text = ""
            operation = 0
        }
    }
    
    
    /*------ Calculator Work Start -------*/
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}


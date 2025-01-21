//
//  ViewController.swift
//  demoMathQuizApp
//
//  Created by apple on 29/01/24.
//

import UIKit

class RangeVC: UIViewController {
    
    //range variable
    private var range : Int!
    //all the button of view
    private var rangeButtons : [UIButton]!
    
    // all views
    @IBOutlet weak var range1to10Btn: UIButton!
    @IBOutlet weak var range11to20Btn: UIButton!
    @IBOutlet weak var range21to30Btn: UIButton!
    @IBOutlet weak var range31to40Btn: UIButton!
    @IBOutlet weak var range41to50Btn: UIButton!
    
    @IBAction func selectRange(_ sender: UIButton) {
     
        //which range is selected
        switch sender.tag{
        case 1 : // range from 1 to 10
            range1to10Btn.setOtherButtonsToFalse(in: rangeButtons)
            range = 1
            break
        case 2 : // range from 11 to 20
            range11to20Btn.setOtherButtonsToFalse(in: rangeButtons)
            range = 11
            break
        case 3 : // range from 21 to 30
            range21to30Btn.setOtherButtonsToFalse(in: rangeButtons)
            range = 21
            break
        case 4 : // range from 31 to 40
            range31to40Btn.setOtherButtonsToFalse(in: rangeButtons)
            range = 31
            break
        case 5 : // range from 41 to 50
            range41to50Btn.setOtherButtonsToFalse(in: rangeButtons)
            range = 41
            break
        default:
            print("Rangevc : ----> Range : non")
        }
        
    }
    
    
    @IBAction func navigateToOperationVC(_ sender: UIButton) {
        //set the range to global get range 
        getrange = range
        if getrange != nil{
            let operationasVC = storyboard?.instantiateViewController(identifier: OperationsVC.storyBoardIdentifier) as! OperationsVC
            navigationController?.pushViewController(operationasVC, animated: true)
        }else{
            let alert = showAlert(title: "Empty Range!", message: "Please Select the range")
            self.present(alert, animated: true)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //rangeButton
        rangeButtons = [range1to10Btn, range11to20Btn, range21to30Btn, range31to40Btn, range41to50Btn]
    }
    
    deinit {
        print("Range view controller's deinit called")
    }

}

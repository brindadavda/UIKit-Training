//
//  ViewController.swift
//  demoContainerView
//
//  Created by apple on 09/01/24.
//

import UIKit

class ViewController: UIViewController {

    var btnTap = true
    
    @IBOutlet weak var oneBtn: UIButton!
    @IBAction func actionOne(_ sender: UIButton) {
        //move from one storyboard to another
        let myView = self.storyboard?.instantiateViewController(identifier: "storyBoard1") as! ViewController
        
        self.present(myView, animated: true)
    }

    @IBAction func actionTwo(_ sender: UIButton) {
        //disble other button work
        if btnTap == true{
            oneBtn.isEnabled = false
            threeBtn.isEnabled = false
            fourBtn.isEnabled = false
            btnTap = false
        }else{
            oneBtn.isEnabled = true
            threeBtn.isEnabled = true
            fourBtn.isEnabled = true
            btnTap = true
        }
    }
    
    
    @IBOutlet weak var threeBtn: UIButton!
    @IBAction func actionThree(_ sender: UIButton) {
        //alert action
        let alertController = UIAlertController(title: "Alert demo", message: "message for alert", preferredStyle: .alert)
        
        let okOption = UIAlertAction(title: "Ok", style: .default)
        
        alertController.addAction(okOption)
        
        self.present(alertController, animated: true)
        
    }
    
  
    @IBOutlet weak var fourBtn: UIButton!
    
    @IBAction func actionFour(_ sender: UIButton) {
        //do your work over here
        if self.view.backgroundColor == UIColor.white{
            self.view.backgroundColor = UIColor.black
            fourBtn.isSelected = false
        }else{
            self.view.backgroundColor = UIColor.white
            fourBtn.isSelected = true
            
        }
    }
    

    @IBOutlet weak var firstLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        firstLabel?.text = "First Label"
        
        print(firstLabel?.text)
        
        

    }
}


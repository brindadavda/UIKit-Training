//
//  ViewController.swift
//  demoapp
//
//  Created by apple on 03/01/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var appName: UILabel!
    
    @IBOutlet weak var greet_label: UILabel!
    
    @IBOutlet weak var user_name: UITextField!
    
    @IBOutlet var backgound: UIView!
    
    @IBOutlet weak var switchButton: UISwitch!
    
    @IBOutlet weak var submitBtn: UIButton!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var stepper: UIStepper!
    
    @IBOutlet weak var result: UILabel!
    
    var sliderValue : Float?
    
    
    @IBAction func submit_btn_click(_ sender: UIButton) {
        let name = user_name.text
        let date = datePicker.date
        let dateFormatterInsatnce = DateFormatter()
        
        datePicker.datePickerMode = .dateAndTime
        dateFormatterInsatnce.dateFormat = "yyyy-MM-dd HH:mm:ss"
        //debug
        print(dateFormatterInsatnce.string(from: datePicker.date))
        
        if let value = sliderValue{
            greet_label.text = "Welcome "+name!+" , "+dateFormatterInsatnce.string(from: date) + "\nslider value : \(value) and count : \(stepper.value)"
        }else{
            greet_label.text = "Welcome "+name!+" , "+dateFormatterInsatnce.string(from: date) + "\n count : \(stepper.value)"
        }

        greet_label.textColor = UIColor.red
        greet_label.isHighlighted = true
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(onTapBackgroundChange(sender:)))
        greet_label.isUserInteractionEnabled = true
        greet_label.addGestureRecognizer(tap)
        
        //on tap event
        switchButton.addTarget(self, action: #selector(switchFun), for: .valueChanged)
        
        
        //for stepper work
        stepper.autorepeat = true
        stepper.isContinuous = true
        
        stepper.maximumValue = 10
        stepper.minimumValue = 0
        result.text = stepper.value.description
    
    }
    
    @IBAction func sliderDidSlide(_ sender : UISlider){
        sliderValue = sender.value
        //debug
        print(sliderValue)
    }
    
    @IBAction func steeperAction(_ sender: UIStepper) {
        print(stepper.value.description)
        result.text = ""+stepper.value.description
    }
    
    //for button tap working
    //change on background color based on label tap
    @objc func onTapBackgroundChange(sender :  UITapGestureRecognizer){
        if(switchButton.isOn){
            backgound.backgroundColor = UIColor.green
            switchButton.setOn(false, animated: false)
        }else{
            backgound.backgroundColor = UIColor.blue
            switchButton.setOn(true, animated: false)
        }
    }
    
    //for switch working
    //button display or not based on switch
    @objc func switchFun(switchState: UISwitch){
        if(switchButton.isOn){
            submitBtn.isHidden = false
        }else{
            submitBtn.isHidden = true
        }
    }
    
  


}


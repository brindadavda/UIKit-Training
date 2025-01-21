//
//  ViewController.swift
//  demoKVC_KVO
//
//  Created by apple on 17/07/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lblResult : UILabel!
    @IBOutlet weak var tfName : UITextField!
    @IBOutlet weak var tfPhone : UITextField!
    
    var student1 : StudentModel!
    
    let combinedObserver = CombinedObserver()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        student1 = StudentModel(id: "1", name: "student1", phoneNumber: 1234567890)
        
//        let name = student1.value(forKey: "name")
//        
//        student1.observe(\.name,options : [.old,.new]){ (student,value) in
//    
//            self.lblResult.text = "old name : \(value.oldValue!) , new name : \(value.newValue!)"
//        }
//        
        
        tfName.text = student1.name
        tfPhone.text = String(student1.phoneNumber)
        
      

       
        if let data : String =  combinedObserver.startObserving(person: student1){
            lblResult.text = data
        }
        
        
    }
    
    
    @IBAction func submitAction(_ sender : UIButton){
     
       
        combinedObserver.updateAgeUsingKVC(person: student1,newName : tfName.text ?? " ")
        
        student1.name = tfName.text ?? " "
        student1.phoneNumber = Int(tfPhone.text ?? " ") ?? 0
    }
    
    

}

func onChange(_ newName : String){
    print("newName : \(newName)")
}


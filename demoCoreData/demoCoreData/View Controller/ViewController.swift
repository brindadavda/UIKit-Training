//
//  ViewController.swift
//  demoCoreData
//
//  Created by apple on 02/02/24.
//

import UIKit
import PhotosUI


class ViewController: UIViewController , UIImagePickerControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // call the createEmployee
        //createEmployee()
       // readEmployee()
        
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
               debugPrint(path[0])
        
        print("ViewController :---> \(path)")
        
        let didTap = UITapGestureRecognizer(target: self, action: #selector(onTapShowgallary(_:)))
    
        profilePicIV.addGestureRecognizer(didTap)
        
        //create and read data
        //createPersonData()
        //readPersonData()
    }

    @IBOutlet weak var profilePicIV: UIImageView!

    @IBOutlet weak var  getEName : UITextField!

    @IBOutlet weak var  getEEmail: UITextField!
    
    @IBOutlet weak var passportIDTF: UITextField!
    
    @IBOutlet weak var passportPlaceOfIssueTF: UITextField!
    
    private let manager : EmployeeManager = EmployeeManager()
    
    @IBAction func displayData(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: "EmployeeDetailsVC") as! EmployeeDetailsVC
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func submitData(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "EmployeeDetailsVC") as! EmployeeDetailsVC
        
        if let name = getEName.text , let email = getEEmail.text , let passportId = passportIDTF.text , let passportPlaceOfIssue = passportPlaceOfIssueTF.text{
            vc.profilePic = profilePicIV.image
            vc.name = "Name : \(name)"
            vc.email = "Email : \(email)"
            
            let passport = Passport(_id: UUID(), _passportId: passportId, _placeOfIssue: passportPlaceOfIssue, _name: name)
            
            let employee = Employee(_name: name, _email: email, _profilePic: (profilePicIV.image?.pngData())!, _id : UUID() , _passport: passport)
        
           manager.create(type: employee)
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func onTapShowgallary(_ action : UITapGestureRecognizer){
        DisplayImagePicker.shared.displayImagePicker(img: profilePicIV, target: self)
    }
    
    //person data creation
    let personManger = PersonManager()
    
    fileprivate func createPersonData(){
        
        let vehical1 = Vehicle(id: UUID(), name: "vehicle1", type: "honda" , brand: "brand1")
        let vehical2 = Vehicle(id: UUID(), name: "vehicle2", type: "honda" , brand: "brand1")
        
        let person1 = Person(id:UUID(), name: "person1",vehicle: [vehical1,vehical2] , email: "email")
        //let person2 = Person(id:UUID(), name: "person2")
        
        personManger.create(type: person1)
        //personManger.create(type: person2)
    }
    
    fileprivate func readPersonData(){
        let data = personManger.fetch()
        
        print("ViewController :---> Result :")
        data?.forEach({result in
            dump(result)
        })
    }
    
    
}


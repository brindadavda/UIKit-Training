//
//  ModifyEmplyeeDetailsVC.swift
//  demoCoreData
//
//  Created by apple on 13/02/24.
//

import UIKit

class ModifyEmplyeeDetailsVC: UIViewController {

    @IBOutlet weak var profilePicIV: UIImageView!
    
    @IBOutlet weak var eNameLabel: UITextField!
    
    @IBOutlet weak var eEmailLabel: UITextField!
    
    @IBOutlet weak var passportIDTF: UITextField!
    
    @IBOutlet weak var passportPlaceOfIssueTF: UITextField!
    
    private let manager : EmployeeManager = EmployeeManager()
    
    var img : Data!
    var name : String!
    var email : String!
    var id : UUID!
    var passportId : String!
    var passportOriginalId : UUID!
    var passportPlaceOfIssue : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        profilePicIV.image = UIImage(data: img)
        eNameLabel.text = name
        eEmailLabel.text = email
        passportIDTF.text = passportId
        passportPlaceOfIssueTF.text = passportPlaceOfIssue
        
        let didTap = UITapGestureRecognizer(target: self, action: #selector(onTapShowgallary(_:)))
    
        profilePicIV.addGestureRecognizer(didTap)
    }
    
    @objc func onTapShowgallary(_ action : UITapGestureRecognizer){
        DisplayImagePicker.shared.displayImagePicker(img: profilePicIV, target: self)
    }
    
    @IBAction func updateEmployeeData(_ sender: UIButton) {
        if let passportOid = passportOriginalId{
            let updatedPassport : Passport = Passport(_id: passportOid, _passportId: passportIDTF.text, _placeOfIssue: passportPlaceOfIssueTF.text)
            
            let updatedEmployee : Employee = Employee(_name: eNameLabel.text!, _email: eEmailLabel.text!, _profilePic: (profilePicIV.image?.pngData())!, _id: id  , _passport: updatedPassport)
            
            if manager.update(type: updatedEmployee){
                showAlert(message:  "Update Successfully")
            }else{
                showAlert(message:  "Error While Updating")
            }
        }
        else{
            showAlert(message:  "Error While Updating")
        }
    }
    
    
    @IBAction func deleteEmployee(_ sender: UIButton) {
        
        let deleteEmployee : Employee = Employee(_name: eNameLabel.text!, _email: eEmailLabel.text!, _profilePic: img, _id: id)
        
        if manager.delete(type: deleteEmployee){
            showAlert(message:  "Deleted Successfully")
        }else{
            showAlert(message:  "Error while Deleting")
        }
        
       
    }
    
    
    func showAlert(message : String){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        let okActionOption = UIAlertAction(title: "Ok", style: .default)
        
        alert.addAction(okActionOption)
        
        present(alert, animated: true)
    }
}

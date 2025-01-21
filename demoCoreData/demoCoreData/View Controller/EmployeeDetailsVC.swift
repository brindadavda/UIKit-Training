//
//  EmployeeDetailsVC.swift
//  demoCoreData
//
//  Created by apple on 13/02/24.
//

import UIKit
import CoreData

class EmployeeDetailsVC: UIViewController , UITableViewDelegate , UITableViewDataSource{
    
    private let manager : EmployeeManager = EmployeeManager()
    
    private lazy var Provider : EmployeeProvider = {
        let dataProvider = EmployeeProvider(with: self)
        return dataProvider
    }()
    
    var employess : [Employee]? = nil
    
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return Provider.featchedResultContoller.fetchedObjects?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! EmployeeTableViewCell
        
        let employee = Provider.featchedResultContoller.fetchedObjects?[indexPath.row]
        
        cell.eNameLabel.text = employee?.name
        cell.eEmailLabel.text = employee?.email
        cell.profileIV.image = UIImage(data:(employee?.profilePic)!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "ModifyEmplyeeDetailsVC") as! ModifyEmplyeeDetailsVC
        
        //let employee : Employee = employess![indexPath.row]
        
        let employee : Employee = Provider.featchedResultContoller.fetchedObjects![indexPath.row].convertToEmployee()
        
        vc.img =  employee.profilePic
        vc.name = employee.name
        vc.email = employee.email
        vc.id = employee.id
        vc.passportId = employee.passport?.passportId
        vc.passportPlaceOfIssue = employee.passport?.placeOfIssue
        vc.passportOriginalId = employee.passport?.id
        
        navigationController?.pushViewController(vc, animated: true)
    }
    

    @IBOutlet weak var tbv: UITableView!
    
    weak var profilePic : UIImage?
    var name : String?
    var email : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        employess = manager.fetch()
        
       /* if employess != nil && employess?.count != 0{
            tbv.reloadData()
        }*/
    }
    
}



extension EmployeeDetailsVC : NSFetchedResultsControllerDelegate{
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tbv.reloadData()
    }
}

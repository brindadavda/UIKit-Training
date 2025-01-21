//
//  PassportVC.swift
//  demoCoreData
//
//  Created by apple on 14/02/24.
//

import UIKit

class PassportVC: UIViewController ,UITableViewDelegate , UITableViewDataSource {
    
    let passportReusableIdentifier = "passportCell"
    
    var data = [Employee]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: passportReusableIdentifier) as! PassportTableViewCell
        
        let employee = data[indexPath.row]
        cell.employeeNameLabel.text = employee.name
        cell.passportIdLabel.text = employee.passport?.passportId
        
        return cell
    }
    

    @IBOutlet weak var tbv: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let manager = EmployeeManager()
        if let employeeData = manager.fetch() {
            data = employeeData
            tbv.reloadData()
        }
    }

}

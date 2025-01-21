//
//  TableViewController.swift
//  demoSplitVC
//
//  Created by apple on 02/03/24.
//

import UIKit
  
  
class TableViewController: UITableViewController {
    var dataArr = Array<String>()
    
    let menuItem = ["Home","Settings","About us","Logout"]
      
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 0..<menuItem.count{
            dataArr.append(menuItem[i])
        }
    }
  
  
    // MARK: - Table view data source
  
  
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
  
  
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
  
  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        cell.cellTitleLbl.text = dataArr[indexPath.row]
        return cell
    }
      
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "ViewController") as! ViewController
     
        vc.text = dataArr[indexPath.row] + " Data"
        
        splitViewController?.showDetailViewController(vc, sender: nil)
    }
}

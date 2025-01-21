//
//  ViewController.swift
//  demoAlertView
//
//  Created by apple on 16/04/24.
//

import UIKit

class ViewController: UIViewController {
    
    var alertCategoryArr = [String]()
    
    @IBOutlet weak var tableVIew: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        alertCategoryArr.append(AlertCategory.mAlert.rawValue)
        alertCategoryArr.append(AlertCategory.wzRootVC.rawValue)
        
        tableVIew.delegate = self
        tableVIew.dataSource = self
    }
}


typealias tableViewProperty = UITableViewDelegate & UITableViewDataSource

extension ViewController : tableViewProperty{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alertCategoryArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AlertDispalyCell.reuableIdentifier) as! AlertDispalyCell
        
        cell.alertlabel.text = alertCategoryArr[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch alertCategoryArr[indexPath.row]{
        case AlertCategory.mAlert.rawValue :
            
            let MalertVC = MalertViewController()
            
            navigationController?.pushViewController(MalertVC, animated: true)
            break
        case AlertCategory.wzRootVC.rawValue :
            let wzRootVC = storyboard?.instantiateViewController(withIdentifier: StoryboardIdentifier.wzRootVC.rawValue) as! WZRootViewController
            
            navigationController?.pushViewController(wzRootVC, animated: true)
            break
        default:
            print("defalut called")
        }
        
      
    }
    
    
}

